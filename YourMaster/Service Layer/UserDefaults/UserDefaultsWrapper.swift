

import Foundation

protocol UserDefaultsWrapperProtocol {
    func updateToken(token: String)
    func getToken() throws -> String
}

enum UserDefaultsError: Error, LocalizedError {
    case invalidToken
}

final class UserDefaultsWrapper: UserDefaultsWrapperProtocol {
    private let defaults = UserDefaults.standard
    
    func updateToken(token: String) {
        defaults.set(token, forKey: AppDefaults.UserDefaults.token)
    }
    
    func getToken() throws -> String {
        guard let token = defaults.string(forKey: AppDefaults.UserDefaults.token) else {
            throw UserDefaultsError.invalidToken
        }
        return token
    }
    
    
}
