
protocol VerifyViewInput: AnyObject {
    func setTitle(title: String)
    func startLoaiding()
    func finishLoading()
    func showError(message: String)
    func hideResendButtonWhenRequest()
}
