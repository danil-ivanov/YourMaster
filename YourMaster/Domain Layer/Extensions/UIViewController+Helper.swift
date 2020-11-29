

import UIKit

extension UIViewController {
    static var upperViewController: UIViewController? {
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}),
              let rootViewController = window.rootViewController else {
            return nil
        }
        
        var upperController: UIViewController? = rootViewController
        var childController = upperController?.presentedViewController
        while childController != nil {
            upperController = childController
            childController = upperController?.presentedViewController
        }
        return upperController
    }
    
    var topBarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0)
            + (navigationController?.navigationBarHeight ?? 0)
    }
}

extension UINavigationController {
    static var upperNavigationController: UINavigationController? {
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}),
              let rootViewController = window.rootViewController else {
            return nil
        }
        var navigationController: UINavigationController?
        var upperController: UIViewController? = rootViewController
        while upperController != nil {
            if upperController is UINavigationController {
                navigationController = upperController as? UINavigationController
                upperController = (upperController as? UINavigationController)?.topViewController
                continue
            }
            upperController = upperController?.presentedViewController
        }
        return navigationController
    }
    
    var navigationBarHeight: CGFloat {
        return navigationBar.frame.size.height
    }
}
