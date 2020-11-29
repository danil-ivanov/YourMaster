
import Foundation

internal typealias AuthorizationCompletion = (Result<Void, AuthorizationError>) -> ()

protocol AuthorizationServiceProtocol {
    func login(with phone: String, completion: @escaping AuthorizationCompletion)
    func verifyCode(code: String, phone: String, completion: @escaping AuthorizationCompletion)
    func logout()
}
