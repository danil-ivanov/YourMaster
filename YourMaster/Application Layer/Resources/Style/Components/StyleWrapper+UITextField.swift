
import Foundation
import UIKit

extension StyleWrapper where Element: UITextField {
    static func phoneStyle(fontSize: CGFloat) -> StyleWrapper {
        return .wrap { textField in
            textField.borderStyle = .none
            textField.keyboardType = .phonePad
            textField.font = SFUIDisplay.regular.font(size: fontSize)
            textField.placeholder = "+0 (000) 000-00-00"
        }
    }
    
    static func pinStyle(spacing: CGFloat) -> StyleWrapper {
        return .wrap { textField in
            textField.defaultTextAttributes.updateValue(spacing, forKey: NSAttributedString.Key.kern)
            textField.borderStyle = .none
            textField.keyboardType = .phonePad
            textField.textContentType = .oneTimeCode
        }
    }
    
    static func underlineStyle(pieces: Int = 1, spacing: CGFloat = 0.0, height: CGFloat, color: UIColor = .gray) -> StyleWrapper {
        return .wrap { textField in
            //let bottomWidth: CGFloat = (UIScreen.main.bounds.width - 60) / CGFloat(pieces) - spacing
            let bottomWidth: CGFloat = ((UIScreen.main.bounds.width - 60) - 4 * spacing) / 4
            for index in 0...pieces - 1 {
                let bottom = CALayer()
                let bottomFrame = CGRect(x:spacing/2 + (bottomWidth + spacing) * CGFloat(index), y: textField.bounds.height - height, width: bottomWidth, height: height)
                bottom.frame = bottomFrame
                bottom.backgroundColor = color.cgColor
                textField.layer.addSublayer(bottom)
                textField.layer.masksToBounds = true
            }
        }
    }
}
