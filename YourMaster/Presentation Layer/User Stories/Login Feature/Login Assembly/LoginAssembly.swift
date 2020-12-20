

import Foundation

///Протокол  сборки сервисов для авторизации
protocol LoginServicesProtocol {

    ///собрать authorizationService
    func authorizationService() -> AuthorizationServiceProtocol
}

///Сущность, которая собирает экраны для авторизации
final class LoginAssembly {
    var serviceAssembly: LoginServicesProtocol
    private lazy var authorizationService: AuthorizationServiceProtocol = serviceAssembly.authorizationService()
    
    private lazy var flowCoordinator: LoginFlowCoordinator = {
        let interactor = LoginInteractor(authorizationService: authorizationService)
        let coordinator = LoginFlowCoordinator(router: LoginFeatureRouter(assembly: self),
                                               interactor: interactor)
        interactor.output = coordinator
        return coordinator
    }()
    
    init(serviceAssembly: LoginServicesProtocol) {
        self.serviceAssembly = serviceAssembly
    }
    
    func featureFlowCoordinator() -> CoordinatorInput & LoginFlowCoordinatorOutput {
        return flowCoordinator
    }
}

extension LoginAssembly: LoginFlowCoordinatorAssemblyProtocol {
    func coordinator() -> CoordinatorInput & LoginFlowCoordinatorOutput {
        return flowCoordinator
    }
}

extension LoginAssembly: LoginAssemblyProtocol {
    func loginViewController() -> LoginViewController {
        let presenter = LoginPresenter(output: flowCoordinator)
        let controller = LoginViewController(output: presenter)
        presenter.view = controller
        flowCoordinator.loginPresenter = presenter
        return controller
    }
    
    func verifyViewController(with phone: String) -> VerifyViewController {
        let presenter = VerifyPresenter(phone: phone, output: flowCoordinator)
        let controller = VerifyViewController(output: presenter)
        presenter.view = controller
        flowCoordinator.verifyPresenter = presenter
        return controller
    }
}
