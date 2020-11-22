//
//  UIViewController+Identifier.swift
//  YourMaster
//
//  Created by Maxim Egorov on 20.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class var identifier: String {
        return String.className(self)
    }
    
}
