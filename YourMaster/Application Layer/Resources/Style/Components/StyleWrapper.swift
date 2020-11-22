//
//  StyleWrapper.swift
//  YourMaster
//
//  Created by Maxim Egorov on 09.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation

typealias Style<Element> = (Element) -> Void

enum StyleWrapper<Element> {
    case wrap(style: Style<Element>)
}