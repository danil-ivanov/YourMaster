

import Foundation
import UIKit

protocol StorkViewOutput: AnyObject {
    func storkViewAnimate(to height: CGFloat)
}

class StorkView: UIView {
    private enum Dimensions {
        static let topOffset: CGFloat = 50.0
        static let cornerRadius: CGFloat = 30.0
        static let downOffset: CGFloat = 20.0
        enum Header {
            static let height: CGFloat = 60.0
            static let minHeight: CGFloat = 60.0
        }
    }
    
    enum AnchorState {
        case top
        case bottom
        case dismissed
    }
    
    let content: UIScrollView
    let header: UIView & ViewHeaderInput
    
    private lazy var headerHeightConstraint: NSLayoutConstraint = header.heightAnchor.constraint(equalToConstant: Dimensions.Header.height)
    
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    private var minHeight: CGFloat {
        didSet {
            if minHeight < 0 {
                minHeight = 0
            }
        }
    }
    
    private var maxHeight: CGFloat {
        didSet {
            if maxHeight > screenHeight {
                maxHeight = screenHeight
            }
        }
    }
    
    private var minOrigin: CGFloat {
        return screenHeight - maxHeight
    }
    
    private var maxOrigin: CGFloat {
        return screenHeight - minHeight
    }
    
    private var downOrigin: CGFloat {
        return screenHeight - Dimensions.downOffset
    }
    
    private var currentOrigin: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            let newHeight = frame.height - (newValue - frame.origin.y)
            frame.origin.y = newValue
            frame.size.height = newHeight
        }
    }
    
    private var headerHeight: CGFloat {
        get {
            return headerHeightConstraint.constant
        }
        set {
            headerHeightConstraint.constant = newValue
        }
    }
    
    private let panGesture = UIPanGestureRecognizer()
    private let tapGesture = UITapGestureRecognizer()
    
    private var dispatchWorkItem: DispatchWorkItem?
    
    private var viewState: ViewDraggableState = .normal
    
    private var anchorState: AnchorState = .bottom {
        didSet {
            
        }
    }
    
    weak var output: StorkViewOutput?
    
    init(minHeight: CGFloat, maxHeight: CGFloat, header: ViewHeader, content: UIScrollView) {
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.header = header
        self.content = content
        super.init(frame: CGRect(x: 0, y: screenHeight - minHeight, width: UIScreen.main.bounds.width, height: maxHeight))
        //setupViews()
        header.addGestureRecognizer(panGesture)
        header.addGestureRecognizer(tapGesture)
        panGesture.addTarget(self, action: #selector(handlePanGesture))
        tapGesture.addTarget(self, action: #selector(handleTapGesture))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.cornerRadius = Dimensions.cornerRadius
        clipsToBounds = true
        header.translatesAutoresizingMaskIntoConstraints = false
        content.translatesAutoresizingMaskIntoConstraints = false
        content.delegate = self
        addSubview(header)
        addSubview(content)
        
        setHeaderConstraints()
        setContentContainerConstraints()
    }
    
    private func setHeaderConstraints() {
        NSLayoutConstraint.activate([header.topAnchor.constraint(equalTo: topAnchor),
                                     header.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     header.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     headerHeightConstraint])
    }
    
    private func setContentContainerConstraints() {
        NSLayoutConstraint.activate([content.topAnchor.constraint(equalTo: header.bottomAnchor),
                                     content.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     content.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     content.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    private func handleAnchorStateChange() {
        switch anchorState {
        case .top:
            setTopState()
        case .bottom:
            setMiddleState(from: .bottom)
        case .dismissed:
            setBottomState()
        }
    }
}

extension StorkView: StorkViewInput {
    private enum AnimationConstants {
        static let upAnimationDuration: CGFloat = 0.5
        static let downAnimationDuration: CGFloat = 0.2
        static let waitBeforeUpAnimationDuration: CGFloat = 1.0
    }
    
    func set(state: AnchorState) {
        anchorState = state
        switch state {
        case .bottom:
            setMiddleState(from: .bottom)
        case .top:
            setTopState()
        case .dismissed:
            setBottomState()
        }
    }
    
    func set(title: String) {
        header.set(title: title)
    }
    
    func showHeader() {
        header.showContent()
    }
    
    func hideHeader() {
        header.hideContent()
    }
}

private extension StorkView {
    enum ViewDraggableState {
        case normal
        case dragging(initialOrigin: CGFloat)
    }
    
    @objc
    func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            viewState = .dragging(initialOrigin: currentOrigin)
        case .changed:
            if case .dragging(let initialOrigin) = viewState {
                let translation = recognizer.translation(in: self).y
                let newOrigin = validateOrigin(initialOrigin + translation)
                currentOrigin = newOrigin
            }
        case .ended:
            viewState = .normal
            let velocity = recognizer.velocity(in: self)
            moveToNextAnchor(velocity)
        case .cancelled, .failed:
            viewState = .normal
        default:
            break
        }
    }
    
    @objc
    func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: TimeInterval(0.2)) {
            self.currentOrigin = self.minOrigin
        }
    }
    
    func validateOrigin(_ target: CGFloat) -> CGFloat {
        let minY = minOrigin
        let maxY = maxOrigin
        if target < minY {
            return minY - sqrt(minY - target)
        } else if target > maxY {
            return maxY + sqrt(target - maxY)
        }
        return target
    }
    
    func moveToNextAnchor(_ velocity: CGPoint) {
        let isUpDirection = velocity.y < 0
        if isUpDirection {
            setTopState()
        } else {
            setMiddleState(from: .top)
        }
    }
    
    func moveHeaderToNextAnchor() {
        let targetHeight = headerHeight > (Dimensions.Header.height + Dimensions.Header.minHeight)/2 ? Dimensions.Header.height : Dimensions.Header.minHeight
        UIView.animate(withDuration: TimeInterval(0.2)) {
            self.layoutIfNeeded()
            self.headerHeight = targetHeight
            self.layoutIfNeeded()
        }
    }
    
    func setTopState() {
        UIView.animate(withDuration: TimeInterval(0.2)) {
            self.currentOrigin = self.minOrigin
        }
    }
    
    func setBottomState() {
        dispatchWorkItem?.cancel()
        DispatchQueue.main.async {
            UIView.animate(withDuration: TimeInterval(AnimationConstants.downAnimationDuration)) {
                self.currentOrigin = self.downOrigin
                self.output?.storkViewAnimate(to: self.screenHeight - self.downOrigin)
            }
        }
    }
    
    func setMiddleState(from state: AnchorState) {
        if state == .bottom {
            let dispatchWorkItem = DispatchWorkItem(block: { [weak self] in
                guard let self = self else { return }
                UIView.animate(withDuration: TimeInterval(AnimationConstants.upAnimationDuration)) {
                    self.currentOrigin = self.maxOrigin
                    self.output?.storkViewAnimate(to: self.minHeight)
                }
            })
            self.dispatchWorkItem = dispatchWorkItem
            
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(AnimationConstants.waitBeforeUpAnimationDuration), execute: dispatchWorkItem)
        } else if state == .top {
            UIView.animate(withDuration: TimeInterval(0.2)) {
                self.currentOrigin = self.maxOrigin
            }
        }
    }
}

extension StorkView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        let newHeaderViewHeight: CGFloat = headerHeight - y

        if newHeaderViewHeight > Dimensions.Header.height {
            headerHeight = Dimensions.Header.height
        } else if newHeaderViewHeight < Dimensions.Header.minHeight {
            headerHeight = Dimensions.Header.minHeight
        } else {
            headerHeight = newHeaderViewHeight
            scrollView.contentOffset.y = 0
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        moveHeaderToNextAnchor()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        moveHeaderToNextAnchor()
    }
}
