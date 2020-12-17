//
//  OrderFlowCoordinator.swift
//  YourMaster
//
//  Created by Maxim Egorov on 04.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation

protocol OrderFlowCoordinatorOutput: AnyObject {
    var orderFlowDidClose: (() -> ())? { get set }
}

final class OrderFlowCoordinator: CoordinatorInput, OrderFlowCoordinatorOutput {
    weak var servicesPresenter: ServicesPresenterInput?
    
    private let router: OrderRouterInput
    var orderFlowDidClose: (() -> ())?
    
    init(router: OrderRouterInput) {
        self.router = router
    }
    
    func start() {
        router.showServices()
    }
}
