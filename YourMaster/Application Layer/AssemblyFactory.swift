
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
