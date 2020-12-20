
final class AssemblyFactory {
    
    private let serviceAssembly: ServiceAssemblyProtocol
    
    init(serviceAssembly: ServiceAssemblyProtocol) {
        self.serviceAssembly = serviceAssembly
    }
}

extension AssemblyFactory: MenuAssemblyFactoryProtocol {
    func createMenuAssembly() -> MenuFlowCoordinatorAssemblyProtocol {
        return MenuAssembly()
    }
}

extension AssemblyFactory: LoginAssemblyFactoryProtocol {
    func createLoginAssembly() -> LoginFlowCoordinatorAssemblyProtocol {
        return LoginAssembly(serviceAssembly: serviceAssembly)
    }
}

extension AssemblyFactory: ShopsAssemblyFactoryProtocol {
    func createShopsAssembly() -> ShopsFlowCoordinatorAssemblyProtocol {
        return ShopsAssembly(coordinatorAssembly: self, serviceAssembly: serviceAssembly)
    }
}

extension AssemblyFactory: OrderAssemblyFactoryProtocol {
    func createOrderAssembly() -> OrderFlowCoordinatorAssemblyProtocol {
        return OrderAssembly()
    }
}
