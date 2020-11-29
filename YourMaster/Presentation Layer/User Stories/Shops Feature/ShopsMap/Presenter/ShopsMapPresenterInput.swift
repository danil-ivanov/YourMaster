

import class CoreLocation.CLLocation
import CoreGraphics

protocol ShopsMapPresenterInput: AnyObject {
    func presentMyLocation(location: CLLocation)
    func presentShops(shops: [Shop])
    func showErrorMessage(message: String)
    func filterShops(name: String)
    func presentAllShops()
}
