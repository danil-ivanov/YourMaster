//
//  MenuFlowCoordinator.swift
//  YourMaster
//
//  Created by Maxim Egorov on 30.11.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

final class MenuFlowCoordinator: CoordinatorInput {
    
    weak var viewController: MenuViewController?
    var router: MenuRouterInput?
    
    func start() {
        router?.showMenu()
    }
}
