

import CoreLocation

protocol ShopsInteractorInput: AnyObject {
    func getShops(radius: Double)
    func requestLocation()
    func getCurrentLocation() -> CLLocation?
    func getServices(for shop: Shop)
    func getReviews(for shopId: Int)
    func cancelServicesRequest()
}
