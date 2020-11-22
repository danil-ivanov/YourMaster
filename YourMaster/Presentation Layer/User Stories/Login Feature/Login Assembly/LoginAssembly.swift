//
//  LoginAssembly.swift
//  YourMaster
//
//  Created by Maxim Egorov on 08.09.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

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
        let coordinator = LoginFlowCoordinator()
        let interactor = LoginInteractor(authorizationService: authorizationService)
        coordinator.interactor = interactor
        coordinator.router = LoginFeatureRouter(assembly: self)
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
        let presenter = LoginPresenter()
        let controller = LoginViewController()
        controller.output = presenter
        presenter.view = controller
        presenter.output = flowCoordinator
        flowCoordinator.loginPresenter = presenter
        return controller
    }
    
    func verifyViewController(with phone: String) -> VerifyViewController {
        let presenter = VerifyPresenter(phone: phone)
        let controller = VerifyViewController()
        controller.output = presenter
        presenter.view = controller
        presenter.output = flowCoordinator
        flowCoordinator.verifyPresenter = presenter
        return controller
    }
}
