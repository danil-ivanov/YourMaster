//
//  MenuView.swift
//  YourMaster
//
//  Created by Maxim Egorov on 30.11.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

protocol MenuViewInput {
    func openMenu()
}

final class MenuView: UIView {

    private enum TouchState {
        case normal
        case dragging(initialWidth: CGFloat)
    }
    
    private let minLeading: CGFloat = -UIScreen.main.bounds.width + 10
    private let maxLeading: CGFloat = 0
    
    private var currentLeading: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    private let panGesture: UIPanGestureRecognizer
    private var touchState: TouchState
    
    override init(frame: CGRect) {
        self.panGesture = UIPanGestureRecognizer()
        self.touchState = .normal
        let rect = CGRect(x: minLeading, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        super.init(frame: rect)
        panGesture.addTarget(self, action: #selector(handlePanGesture))
        addGestureRecognizer(panGesture)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 20.0
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 50, height: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            touchState = .dragging(initialWidth: currentLeading)
        case .changed:
            if case .dragging(let initialWidth) = touchState {
                let translation = recognizer.translation(in: self).x
                let newWidth = validateOrigin(initialWidth + translation)
                currentLeading = newWidth
            }
        case .ended:
            touchState = .normal
            let velocity = recognizer.velocity(in: self)
            moveToNextAnchor(velocity)
        case .cancelled, .failed:
            touchState = .normal
        default:
            break
        }
    }
    
    private func validateOrigin(_ target: CGFloat) -> CGFloat {
        if target < minLeading {
            return minLeading
        } else if target > maxLeading {
            return maxLeading
        }
        return target
    }
    
    private func moveToNextAnchor(_ velocity: CGPoint) {
        let isLeftDirection = velocity.x <= 0
        if isLeftDirection {
            UIView.animate(withDuration: 0.2) {
                self.currentLeading = self.minLeading
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.currentLeading = self.maxLeading
            }
        }
    }
}

extension MenuView: MenuViewInput {
    func openMenu() {
        UIView.animate(withDuration: 0.2) {
            self.currentLeading = self.maxLeading
        }
    }
}
