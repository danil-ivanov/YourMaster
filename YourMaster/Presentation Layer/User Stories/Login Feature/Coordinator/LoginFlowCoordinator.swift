//
//  LoginCoordinator.swift
//  YourMaster
//
//  Created by Maxim Egorov on 11.09.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//
import Foundation

protocol LoginFlowCoordinatorOutput: AnyObject {
    var onLoginSucces: (() -> ())? { get set }
}

final class LoginFlowCoordinator: LoginFlowCoordinatorOutput {
    var router: LoginFeatureRouter?
    var interactor: LoginInteractorInput?
    weak var loginPresenter: LoginPresenterInput?
    weak var verifyPresenter: VerifyPresenterInput?
    
    var onLoginSucces: (() -> ())?
}

extension LoginFlowCoordinator: CoordinatorInput {
    func start() {
        router?.showLogin()
    }
}

extension LoginFlowCoordinator: LoginPresenterOutput {
    func didRequestLogin(with phone: String) {
        interactor?.login(with: phone)
    }
}

extension LoginFlowCoordinator: VerifyPresenterOutput {
    func didRequestVerify(code: String, phone: String) {
        interactor?.sendVerficationCode(code: code, phone: phone)
    }
    
    func didRequestResendSMS(phone: String) {
        interactor?.login(with: phone)
    }
}

extension LoginFlowCoordinator: LoginInteractorOutput {
    func didLogin() {
        verifyPresenter?.finishVerify()
        onLoginSucces?()
    }
    
    func didSendCode(to phone: String) {
        //loginPresenter?.stopSending()
        router?.showVerifyScene(with: phone)
    }
    
    func didReceiveError(message: String) {
        loginPresenter?.showError(message: message)
    }
}
