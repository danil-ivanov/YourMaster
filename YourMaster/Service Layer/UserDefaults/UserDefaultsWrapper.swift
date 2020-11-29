
import Foundation

protocol UserDefaultsWrapperProtocol {
    func updateToken(token: String)
    func getToken() throws -> String
    
    func update(user: User)
    func getUser() throws -> User
}

enum UserDefaultsError: Error, LocalizedError {
    case invalidToken
    case invalidUser
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
    
    func update(user: User) {
        guard let data = try? JSONEncoder().encode(user) else {
            return
        }
        defaults.set(data, forKey: AppDefaults.UserDefaults.user)
    }
    
    func getUser() throws -> User {
        guard let data = defaults.data(forKey: AppDefaults.UserDefaults.user),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            throw UserDefaultsError.invalidUser
        }
        return user
    }
}
