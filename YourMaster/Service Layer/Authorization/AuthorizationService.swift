
import Foundation

final class AuthorizationService: AuthorizationServiceProtocol {
    private let networkDispatcher: Dispatcher
    private let userDefaults: UserDefaultsWrapperProtocol
    private let approvedString = "\"APPROVED\""
    
    init(networkDispatcher: Dispatcher, userDefaults: UserDefaultsWrapperProtocol) {
        self.networkDispatcher = networkDispatcher
        self.userDefaults = userDefaults
    }
    
    func login(with phone: String, completion: @escaping AuthorizationCompletion) {
        let request = AuthorizationRequest(with: phone)
        networkDispatcher.execute(request: request) { result in
            switch result {
            case .success(let response):
                let code = response.statusCode
                if code >= 200 && code <= 299 {
                    completion(Result.success(()))
                    return
                }
                if code >= 400 && code <= 499 {
                    completion(Result.failure(AuthorizationError.unauthorized))
                }
                
                if code >= 500 && code <= 599 {
                    completion(Result.failure(AuthorizationError.internalError))
                }
            case .failure(let error):
                completion(Result.failure(AuthorizationError.networkError(error: error)))
            }
        }
    }
    
    func verifyCode(code: String, phone: String, completion: @escaping AuthorizationCompletion) {
        let request = VerficationRequest(code: code, phone: phone)
        networkDispatcher.execute(request: request) { [weak self ] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let code = response.statusCode
                if code >= 200 && code <= 299 {
                    let string = String(data: response.data, encoding: .utf8)
                    if string == self.approvedString {
                        guard let authToken = response.response?.allHeaderFields[AppDefaults.UserDefaults.token] as? String else {
                            completion(Result.failure(AuthorizationError.forbidden))
                            return
                        }
                        self.userDefaults.updateToken(token: authToken)
                        completion(Result.success(()))
                        return
                    }
                    completion(Result.failure(AuthorizationError.invalidCode))
                    return
                }
                if code >= 400 && code <= 499 {
                    completion(Result.failure(AuthorizationError.unauthorized))
                }
                
                if code >= 500 && code <= 599 {
                    completion(Result.failure(AuthorizationError.internalError))
                }
            case .failure(let error):
                completion(Result.failure(AuthorizationError.networkError(error: error)))
            }
        }
    }
    
    func logout() {
        
    }
    
    deinit {
        print("Deinit Authorization")
    }
}
