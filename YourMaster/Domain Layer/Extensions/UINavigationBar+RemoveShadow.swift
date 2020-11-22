//
//  UINavigationBar+RemoveShadow.swift
//  YourMaster
//
//  Created by Maxim Egorov on 14.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}
