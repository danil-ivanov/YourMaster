

import Foundation
import UIKit

extension UIViewController {
    class var identifier: String {
        return String.className(self)
    }
    
}
