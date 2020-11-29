

protocol VerifyPresenterInput: AnyObject {
    func configure()
    func finishVerify()
    func showError(message: String)
}
