//
//  AssemblyFactory.swift
//  YourMaster
//
//  Created by Maxim Egorov on 27.10.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

final class AssemblyFactory {
    
    private let serviceAssembly: ServiceAssemblyProtocol
    
    init(serviceAssembly: ServiceAssemblyProtocol) {
        self.serviceAssembly = serviceAssembly
    }
}

extension AssemblyFactory: LoginAssemblyFactoryProtocol {
    func createLoginAssembly() -> LoginFlowCoordinatorAssemblyProtocol {
        return LoginAssembly(serviceAssembly: serviceAssembly)
    }
}

extension AssemblyFactory: ShopsAssemblyFactoryProtocol {
    func createShopsAssembly() -> ShopsFlowCoordinatorAssemblyProtocol {
        return ShopsAssembly(serviceAssembly: serviceAssembly)
    }
}
