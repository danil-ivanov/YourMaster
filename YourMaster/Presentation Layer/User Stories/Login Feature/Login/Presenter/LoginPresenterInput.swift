
protocol LoginPresenterInput: AnyObject {
    func stopSending()
    func showError(message: String)
}
