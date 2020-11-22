//
//  UILabel+Extension.swift
//  YourMaster
//
//  Created by Maxim Egorov on 09.11.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

extension UILabel {

    var isTruncated: Bool {
        guard let labelText = text else {
            return false
        }

        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size

        return labelTextSize.height > bounds.size.height
    }
}
