//
//  AuthorizationServiceProtocol.swift
//  YourMaster
//
//  Created by Maxim Egorov on 10.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation

internal typealias AuthorizationCompletion = (Result<Void, AuthorizationError>) -> ()

protocol AuthorizationServiceProtocol {
    func login(with phone: String, completion: @escaping AuthorizationCompletion)
    func verifyCode(code: String, phone: String, completion: @escaping AuthorizationCompletion)
    func logout()
}
