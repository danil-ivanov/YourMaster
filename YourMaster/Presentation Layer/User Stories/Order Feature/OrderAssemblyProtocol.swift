//
//  OrderAssemblyProtocol.swift
//  YourMaster
//
//  Created by Maxim Egorov on 04.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

protocol OrderAssemblyProtocol {
    
}

protocol OrderFlowCoordinatorAssemblyProtocol {
    func coordinator() -> CoordinatorInput & OrderFlowCoordinatorOutput
}

protocol OrderAssemblyFactoryProtocol {
    func createOrderAssembly() -> OrderFlowCoordinatorAssemblyProtocol
}
