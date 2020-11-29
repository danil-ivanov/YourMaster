

import UIKit

extension UIView {
    func subviewsContains(_ point: CGPoint) -> Bool {
        return subviews.contains(where: { $0.frame.contains(point) })
    }
}

class TouchesPassView: UIView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return subviewsContains(point)
    }
}
