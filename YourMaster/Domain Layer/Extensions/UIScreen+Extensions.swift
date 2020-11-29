
import UIKit

extension UIScreen {
    static var noStatusBarHeight: CGFloat {
        guard let statusBarFrame = UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.windowScene?.statusBarManager?.statusBarFrame
        else {
            return UIScreen.main.bounds.height
        }
        return UIScreen.main.bounds.height - statusBarFrame.height
    }
    
    static var statusBarHeight: CGFloat {
        guard let statusBarFrame = UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.windowScene?.statusBarManager?.statusBarFrame
        else {
            return 0.0
        }
        return statusBarFrame.height
    }
}
