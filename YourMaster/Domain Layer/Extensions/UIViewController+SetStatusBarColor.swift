

import UIKit

final class StatusBarView: UIView {}

extension UIViewController {
    func setStatusBarColor(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            if color == UIColor.clear {
                view.subviews.first(where: {$0 is StatusBarView})?.removeFromSuperview()
                return
            }
            let app = UIApplication.shared
            guard let statusBarManager = app.windows.first(where: {$0.isKeyWindow})?.windowScene?.statusBarManager else {
                return
            }
            view.subviews.first(where: {$0 is StatusBarView})?.removeFromSuperview()
            let statusBarHeight: CGFloat = statusBarManager.statusBarFrame.height
            
            let statusbarView = StatusBarView()
            statusbarView.backgroundColor = color
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
            view.layoutIfNeeded()
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
}
