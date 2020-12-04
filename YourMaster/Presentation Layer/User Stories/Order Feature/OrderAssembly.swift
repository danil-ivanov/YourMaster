//
//  OrderAssembly.swift
//  YourMaster
//
//  Created by Maxim Egorov on 04.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

final class OrderAssembly {

    private lazy var flowCoordinator: OrderFlowCoordinator = {
        let router = OrderRouter(assembly: self)
        return OrderFlowCoordinator(router: router)
    }()
}

extension OrderAssembly: OrderFlowCoordinatorAssemblyProtocol {
    func coordinator() -> CoordinatorInput & OrderFlowCoordinatorOutput {
        return flowCoordinator
    }
}

extension OrderAssembly: OrderAssemblyProtocol {
    func servicesController() -> ServicesViewController {
        let presenter = ServicesPresenter(output: flowCoordinator)
        let controller = ServicesViewController(output: presenter)
        presenter.view = controller
        flowCoordinator.servicesPresenter = presenter
        return controller
    }
}
