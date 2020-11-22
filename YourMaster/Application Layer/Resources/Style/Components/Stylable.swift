//
//  Stylable.swift
//  YourMaster
//
//  Created by Maxim Egorov on 09.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation

protocol Stylable { }

extension NSObject: Stylable { }

extension Stylable {
    
    static func style(style: @escaping Style<Self>) -> Style<Self> { return style }
    
    func apply(_ style: StyleWrapper<Self>...) {
        style.forEach {
            switch $0 {
            case let .wrap(style):
                style(self)
            }
        }
    }
}
