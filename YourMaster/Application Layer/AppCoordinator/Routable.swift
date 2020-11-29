
protocol Routable {
    associatedtype ScreenType
    func route(to screen: ScreenType)
}
