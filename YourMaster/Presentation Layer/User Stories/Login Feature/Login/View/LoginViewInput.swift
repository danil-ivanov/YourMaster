

protocol LoginViewInput: AnyObject {
    func startLoaiding()
    func finishLoading()
    func showError(message: String)
}
