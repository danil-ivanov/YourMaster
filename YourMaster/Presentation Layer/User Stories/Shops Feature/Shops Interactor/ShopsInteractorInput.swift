

import CoreLocation

protocol ShopsInteractorInput: AnyObject {
    func getShops(radius: Double)
    func requestLocation()
    func getCurrentLocation() -> CLLocation?
}
