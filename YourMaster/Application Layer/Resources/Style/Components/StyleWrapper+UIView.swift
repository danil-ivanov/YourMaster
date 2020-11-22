//
//  StyleWrapper+UIView.swift
//  YourMaster
//
//  Created by Maxim Egorov on 09.10.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

extension StyleWrapper where Element: UIView {
    
    static func roundedStyle(radius: CGFloat = 0.0) -> StyleWrapper {
        return .wrap { view in
            view.layer.cornerRadius =  radius < 0.001 ? view.bounds.height / 2 : radius
            view.clipsToBounds = true
        }
    }
    
    static func borderStyle(borderColor: UIColor, borderWidth: CGFloat) -> StyleWrapper {
        return .wrap { view in
            view.layer.borderWidth = borderWidth
            view.layer.borderColor = borderColor.cgColor
        }
    }
    
    static func gradientStyle(colors: [CGColor], locations: [CGFloat]) -> StyleWrapper {
        return .wrap { view in
            let gradient = CAGradientLayer()
            gradient.colors = colors
            gradient.locations = locations as [NSNumber]
            gradient.frame = view.bounds
            view.layer.insertSublayer(gradient, at: 0)
        }
    }
}
