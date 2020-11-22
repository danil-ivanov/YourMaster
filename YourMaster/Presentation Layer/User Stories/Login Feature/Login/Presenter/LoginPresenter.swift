//
//  LoginPresenter.swift
//  YourMaster
//
//  Created by Maxim Egorov on 22.09.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

protocol LoginPresenterOutput: AnyObject {
    func didRequestLogin(with phone: String)
}

final class LoginPresenter {
    var output: LoginPresenterOutput?
    weak var view: LoginViewInput?
}

extension LoginPresenter: LoginPresenterInput {
    func stopSending() {
        view?.finishLoading()
    }
    
    func showError(message: String) {
        view?.finishLoading()
        view?.showError(message: message)
    }
}

extension LoginPresenter: LoginViewOutput {
    func didRequesLogin(with phone: String) {
        view?.startLoaiding()
        output?.didRequestLogin(with: phone)
    }
}