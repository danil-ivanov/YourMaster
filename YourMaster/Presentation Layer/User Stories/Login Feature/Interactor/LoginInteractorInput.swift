//
//  LoginInteractorInput.swift
//  YourMaster
//
//  Created by Maxim Egorov on 22.09.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

///Протокол для взаимодействия с интерактором для авторизации
protocol LoginInteractorInput {

    ///метод, который инициирует отправку смс-кода
    /// - Parameter phone: - номер телефона, куда придет смс-код
    func login(with phone: String)

    ///метод, проверяющий смс-код
    /// - Parameter code: - смс-код
    /// - Parameter phone: - номер телефона
    func sendVerficationCode(code: String, phone: String)
}
