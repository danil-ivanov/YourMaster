//
//  StyleWrapper+UIButton.swift
//  YourMaster
//
//  Created by Maxim Egorov on 11.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation
import UIKit

extension StyleWrapper where Element: UIButton {
    
    static func interactionEnaledStyle() -> StyleWrapper {
        return .wrap { button in
            button.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.3) {
                button.backgroundColor = AppTheme.accentColor
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
