//
//  MenuAssembly.swift
//  YourMaster
//
//  Created by Maxim Egorov on 30.11.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation

final class MenuAssembly {

    private lazy var flowCoordinator: MenuFlowCoordinator = {
        let router = MenuRouter(assembly: self)
        let coordinator = MenuFlowCoordinator()
        coordinator.router = router
        return coordinator
    }()
}

extension MenuAssembly: MenuFlowCoordinatorAssemblyProtocol {
    func coordinator() -> CoordinatorInput {
        return flowCoordinator
    }
}

extension MenuAssembly: MenuAssemblyProtocol {
    func menuController() -> MenuViewController {
        let controller = MenuViewController()
        flowCoordinator.viewController = controller
        return controller
    }
}
