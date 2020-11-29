

protocol LoginInteractorOutput: AnyObject {
    func didLogin()
    func didSendCode(to phone: String)
    func didReceiveError(message: String)
}

final class LoginInteractor {

    ///Выход интерактора
    weak var output: LoginInteractorOutput?
    
    // MARK: - Private Properties

    private let authorizationService: AuthorizationServiceProtocol
    
    init(authorizationService: AuthorizationServiceProtocol) {
        self.authorizationService = authorizationService
    }
}

extension LoginInteractor: LoginInteractorInput {
    func login(with phone: String) {
        authorizationService.login(with: phone) { [weak self] result in
            switch result {
            case .success():
                self?.output?.didSendCode(to: phone)
            case .failure(let error):
                self?.output?.didReceiveError(message: error.errorDescription ?? "")
            }
        }
    }
    
    func sendVerficationCode(code: String, phone: String) {
        authorizationService.verifyCode(code: code, phone: phone) { [weak self] result in
            switch result {
            case .success():
                self?.output?.didLogin()
            case .failure(let error):
                self?.output?.didReceiveError(message: error.errorDescription ?? "")
            }
        }
    }
}
