//
//  MenuAssemblyProtocol.swift
//  YourMaster
//
//  Created by Maxim Egorov on 30.11.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

protocol MenuAssemblyProtocol {
    func menuController() -> MenuViewController
}

protocol MenuFlowCoordinatorAssemblyProtocol {
    func coordinator() -> CoordinatorInput
}

protocol MenuAssemblyFactoryProtocol {
    func createMenuAssembly() -> MenuFlowCoordinatorAssemblyProtocol
}
