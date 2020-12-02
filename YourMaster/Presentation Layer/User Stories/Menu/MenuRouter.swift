//
//  MenuRouter.swift
//  YourMaster
//
//  Created by Maxim Egorov on 30.11.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

protocol MenuRouterInput {
    func showMenu()
}

final class MenuRouter: MenuRouterInput {
    
    private let navigationController: UINavigationController?
    private let assembly: MenuAssemblyProtocol
    
    init(assembly: MenuAssemblyProtocol) {
        self.assembly = assembly
        self.navigationController = UINavigationController.upperNavigationController
    }
    
    func showMenu() {
        guard let viewController = navigationController?.topViewController as? ShopsMapViewController else {
            return
        }
        let menuController = assembly.menuController()
        viewController.addChild(menuController)
        viewController.view.addSubview(menuController.view)
    }
}
