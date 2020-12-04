//
//  OrderRouter.swift
//  YourMaster
//
//  Created by Maxim Egorov on 04.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

protocol OrderRouterInput {
    func showServices()
}

final class OrderRouter: OrderRouterInput {
    private let assembly: OrderAssemblyProtocol
    private weak var navigationController: UINavigationController?
    
    init(assembly: OrderAssemblyProtocol) {
        self.assembly = assembly
        self.navigationController = UINavigationController.upperNavigationController
    }
    
    func showServices() {
        let controller = assembly.servicesController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
