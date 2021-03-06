

protocol LoginPresenterOutput: AnyObject {
    func didRequestLogin(with phone: String)
}

final class LoginPresenter {
    private let output: LoginPresenterOutput
    weak var view: LoginViewInput?
    
    init(output: LoginPresenterOutput) {
        self.output = output
    }
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
        output.didRequestLogin(with: phone)
    }
}
