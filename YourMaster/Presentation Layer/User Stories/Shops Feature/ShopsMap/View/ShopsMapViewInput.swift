

import Foundation
import class CoreLocation.CLLocation
import CoreGraphics

protocol ShopsMapViewInput: AnyObject {
    func prepareInterface()
    func presentMyLocation(location: CLLocation)
    func startLoading()
    func finishLoading()
    func showErrorMessage(message: String)
}
