//
//  AuthorizationError.swift
//  YourMaster
//
//  Created by Maxim Egorov on 11.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation

enum AuthorizationError: Error, LocalizedError {
    case dataError
    case unauthorized
    case forbidden
    case internalError
    case networkError(error: NetworkError)
    case invalidCode
    
    var errorDescription: String? {
        switch self {
        case .dataError:
            return "Что-то пошло не так"
        case .unauthorized:
            return "Доступ запрещен"
        case .forbidden:
            return "Доступ запрещен"
        case .internalError:
            return "Что-то пошло не так"
        case .networkError(let error):
            return error.errorDescription
        case .invalidCode:
            return "Неверный код"
        }
    }

    
}
