

protocol ShopsListPresenterInput: AnyObject {
    func presentShops(shops: [Shop])
    func setStorkState(state: BottomListView.PositionState)
    func stopLoadingifNeeded()
}
