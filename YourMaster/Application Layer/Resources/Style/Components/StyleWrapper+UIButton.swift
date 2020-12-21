

import Foundation
import UIKit

extension StyleWrapper where Element: UIButton {
    
    static func interactionEnaledStyle() -> StyleWrapper {
        return .wrap { button in
            button.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.3) {
                button.backgroundColor = AppColors.accentColor
            }
        }
    }
    
    static func interactionDisabledStyle() -> StyleWrapper {
        return .wrap { button in
            button.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.3) {
                button.backgroundColor = .lightGray
            }
        }
    }
}
