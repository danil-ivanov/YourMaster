//
//  LoginAssemblyProtocol.swift
//  YourMaster
//
//  Created by Maxim Egorov on 08.09.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation

///Протокол сущности, которая собирается экраны  авторизации
protocol LoginAssemblyProtocol {

    ///собрать экран ввода номера телефона
    func loginViewController() -> LoginViewController

    ///собрать экран подтверждения смс-кода
    /// - Parameter phone: - номер телефона
    func verifyViewController(with phone: String) -> VerifyViewController
}

///Протокол сущности, которая собирает коордиантор
protocol LoginFlowCoordinatorAssemblyProtocol {
    
    ///собрать координатор
    func coordinator() -> CoordinatorInput & LoginFlowCoordinatorOutput
}

///протокол для сборки assembly на фабрике
protocol LoginAssemblyFactoryProtocol {
    
    ///собрать assembly
    func createLoginAssembly() -> LoginFlowCoordinatorAssemblyProtocol
}
