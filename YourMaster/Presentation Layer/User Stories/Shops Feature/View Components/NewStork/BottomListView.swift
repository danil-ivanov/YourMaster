

import UIKit

protocol BottomListViewOutput: AnyObject {
    func didUpdateHeight(newHeight: CGFloat)
}

final class BottomListView: UIView {
    
    // MARK: - Private Properties
    
    private enum Layout {
        static let cornerRadius: CGFloat = 20.0
        static let shadowRadius: CGFloat = 4.0
        static let shadowOpacity: Float = 0.2
        static let shadowOffset: CGSize = .zero
    }
    
    enum PositionState {
        case fullScreen
        case middle
        case dismissed
        
        static var minOrigin: CGFloat {
            return PositionState.fullScreen.origin
        }
        
        static var maxOrigin: CGFloat {
            return PositionState.middle.origin
        }
        
        var height: CGFloat {
            switch self {
            case .fullScreen:
                return UIScreen.main.bounds.height - 50
            case .middle:
                return 200
            case .dismissed:
                return 50
            }
        }
        
        var origin: CGFloat {
            return UIScreen.main.bounds.height - height
        }
    }
    
    private enum TouchState {
        case normal
        case dragging(initialOrigin: CGFloat)
    }
    
    private var currentOrigin: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            let newHeight = frame.height - (newValue - frame.origin.y)
            frame.origin.y = newValue
            frame.size.height = newHeight
            output?.didUpdateHeight(newHeight: newHeight)
        }
    }
    
    private let content: UIScrollView
    private var positionState: PositionState
    private var touchState: TouchState
    
    private var showWorkItem: DispatchWorkItem?
    private var animator: UIViewPropertyAnimator?
    
    weak var output: BottomListViewOutput?

    // MARK: - Initialization
    
    init(content: UIScrollView) {
        self.content = content
        self.positionState = .middle
        self.touchState = .normal
        let frame = CGRect(x: 0, y: positionState.origin, width: UIScreen.main.bounds.width, height: positionState.height)
        super.init(frame: frame)
        setupShadow()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = positionState == .fullScreen ? 0 : 20
    }
    
    func set(position: PositionState) {
        switch position {
        case .fullScreen:
            showWorkItem?.cancel()
            showWorkItem = nil
            scroll(to: PositionState.fullScreen.origin, animated: true)
            positionState = .fullScreen
        case .middle:
            if positionState == .dismissed {
                let animatorWorkItem = DispatchWorkItem(block: { [weak self] in
                    guard let self = self else { return }
                    self.scroll(to: PositionState.middle.origin, animated: true)
                    self.positionState = .middle
                })
                self.showWorkItem = animatorWorkItem
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: animatorWorkItem)
                return
            }
            scroll(to: PositionState.middle.origin, animated: true)
            positionState = .middle
        case .dismissed:
            showWorkItem?.cancel()
            showWorkItem = nil
            DispatchQueue.main.async {
                self.scroll(to: PositionState.dismissed.origin, animated: true)
                self.positionState = .dismissed
            }
        }
        setNeedsLayout()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        clipsToBounds = true
        backgroundColor = .white
        layer.cornerRadius = 20
        content.translatesAutoresizingMaskIntoConstraints = false
        addSubview(content)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([content.topAnchor.constraint(equalTo: topAnchor),
                                     content.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     content.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     content.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    private func setupShadow() {
        layer.shadowRadius = Layout.shadowRadius
        layer.shadowOpacity = Layout.shadowOpacity
        layer.shadowOffset = Layout.shadowOffset
    }
    
    private func validateOrigin(_ target: CGFloat) -> CGFloat {
        let minY = PositionState.minOrigin
        let maxY = PositionState.maxOrigin
        if target < minY {
            return minY - sqrt(minY - target)
        } else if target > maxY {
            return maxY + sqrt(target - maxY)
        }
        return target
    }
    
    private func moveToNextAnchor(_ velocity: CGPoint) {
        let isUpDirection = velocity.y <= 0
        if isUpDirection {
            set(position: .fullScreen)
        } else {
            set(position: .middle)
        }
    }
    
    private func scroll(to originY: CGFloat, animated: Bool = false, velocity: CGPoint? = nil) {
        guard animated else {
            currentOrigin = originY
            return
        }
        var duration: CGFloat = 0.2
        if let velocity = velocity {
            duration = abs(currentOrigin - originY) / (velocity.y)
        }
        duration = duration > 0.2 ? 0.2 : duration
        let animator = UIViewPropertyAnimator(duration: TimeInterval(duration), curve: .easeIn) {
            self.currentOrigin = originY
            self.superview?.layoutIfNeeded()
        }
        animator.startAnimation()
    }
}

extension BottomListView: ShopsScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let isUpDirection = scrollView.panGestureRecognizer.velocity(in: self).y <= 0
        switch positionState {
        case .middle:
            touchState = .dragging(initialOrigin: currentOrigin)
        case .fullScreen:
            if !isUpDirection && scrollView.contentOffset.y <= 0.0 {
                touchState = .dragging(initialOrigin: currentOrigin)
            }
        default:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if case .dragging(let initialOrigin) = touchState {
            let translation = scrollView.panGestureRecognizer.translation(in: self).y
            let newOrigin = validateOrigin(initialOrigin + translation)
            currentOrigin = newOrigin
            scrollView.contentOffset.y = 0
            return
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if case .dragging(_) = touchState {
            touchState = .normal
            moveToNextAnchor(scrollView.panGestureRecognizer.velocity(in: self))
            return
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if case .dragging(_) = touchState {
            targetContentOffset.pointee = scrollView.contentOffset
        }
    }
}
