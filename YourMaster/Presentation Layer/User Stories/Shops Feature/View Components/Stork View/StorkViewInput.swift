

protocol StorkViewInput: AnyObject {
    func set(title: String)
    func showHeader()
    func hideHeader()
    func set(state: StorkView.AnchorState)
}
