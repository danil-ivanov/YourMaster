
import Foundation
import UIKit

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last ?? ""
    }
    
    func numberOfLines(in label: UILabel) -> Int {
        guard let text = label.text else {
            return 0
        }
        let myText = text as NSString
        let rect = CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [.font: label.font], context: nil)
        return Int(ceil(CGFloat(labelSize.height) / label.font.lineHeight))
    }
}
