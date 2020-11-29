

protocol VerifyPresenterOutput: AnyObject {
    func didRequestVerify(code: String, phone: String)
    func didRequestResendSMS(phone: String)
}

final class VerifyPresenter {
    var output: VerifyPresenterOutput?
    weak var view: VerifyViewInput?
    
    let phone: String
    
    init(phone: String) {
        self.phone = phone
    }
}

extension VerifyPresenter: VerifyPresenterInput {
    func finishVerify() {
        view?.finishLoading()
    }
    
    func showError(message: String) {
        view?.showError(message: message)
    }
}

extension VerifyPresenter: VerifyViewOutput {
    func configure() {
        view?.setTitle(title: phone)
    }
    
    func didRequestVerify(code: String) {
        output?.didRequestVerify(code: code, phone: phone)
    }
    
    func didRequestResendSMS() {
        view?.hideResendButtonWhenRequest()
        output?.didRequestResendSMS(phone: phone)
    }
}
