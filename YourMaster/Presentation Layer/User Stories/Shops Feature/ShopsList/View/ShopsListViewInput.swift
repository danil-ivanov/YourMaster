

protocol ShopsListViewInput: AnyObject {
    func prepareInterface()
    func set(state: BottomListView.PositionState)
    func presentShops()
    func startLoading()
    func finishLoading()
}
