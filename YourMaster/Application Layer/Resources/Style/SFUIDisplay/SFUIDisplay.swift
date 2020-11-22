//
//  SFUIDisplay.swift
//  NoviNexus
//
//  Created by Vladislav on 07.02.2020.
//  Copyright © 2020 Vladislav Markov. All rights reserved.
//

import UIKit

enum SFUIDisplay {
    case ultralight
    case thin
    case light
    case medium
    case regular
    case semibold
    case bold
    case heavy
    case black

    public func font(size: CGFloat) -> UIFont {
        switch self {
        case .ultralight:
            if let font = UIFont(name: "SFUIDisplay-Ultralight", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size, weight: .ultraLight)
        case .thin:
            if let font = UIFont(name: "SFUIDisplay-Thin", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size, weight: .thin)
        case .light:
            if let font = UIFont(name: "SFUIDisplay-Light", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size, weight: .light)
        case .medium:
            if let font = UIFont(name: "SFUIDisplay-Medium", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size, weight: .medium)
        case .regular:
            if let font = UIFont(name: "SFUIDisplay-Regular", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size, weight: .regular)
        case .semibold:
            if let font = UIFont(name: "SFUIDisplay-Semibold", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        case .bold:
            if let font = UIFont(name: "SFUIDisplay-Bold", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size, weight: .bold)
        case .heavy:
            if let font = UIFont(name: "SFUIDisplay-Heavy", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size, weight: .heavy)
        case .black:
            if let font = UIFont(name: "SFUIDisplay-Black", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size, weight: .black)
        }
    }
    
    func sizeOfChar(with fontSize: CGFloat) -> CGSize {
        return NSString(string: "0").size(withAttributes: [.font: self.font(size: fontSize)])
    }
}
