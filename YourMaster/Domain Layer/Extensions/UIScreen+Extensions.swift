//
//  UIScreen+NoStatusBar.swift
//  YourMaster
//
//  Created by Maxim Egorov on 06.10.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

extension UIScreen {
    static var noStatusBarHeight: CGFloat {
        guard let statusBarFrame = UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.windowScene?.statusBarManager?.statusBarFrame
        else {
            return UIScreen.main.bounds.height
        }
        return UIScreen.main.bounds.height - statusBarFrame.height
    }
    
    static var statusBarHeight: CGFloat {
        guard let statusBarFrame = UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.windowScene?.statusBarManager?.statusBarFrame
        else {
            return 0.0
        }
        return statusBarFrame.height
    }
}
