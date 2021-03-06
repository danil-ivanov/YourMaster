
import Foundation
import GoogleMapsUtils

protocol ShopsInteractorOutput: AnyObject {
    func didReceiveShops(shops: [Shop])
    func didReceiveServices(servicesDict: [String: [Service]])
    func didReceiveReviews(reviews: [Review])
    func didReceiveErrorMessage(message: String)
    func didUpdateLocation(location: CLLocation)
}

final class ShopsInteractor: NSObject {
    private let shopService: ShopsServiceProtocol
    private let locationManager: CLLocationManager
    
    weak var output: ShopsInteractorOutput?
    
    private var isFirstUpdateLocation: Bool
    
    private var defferredGetShops: (() -> ())?
    
    init(shopService: ShopsServiceProtocol, locationManager: CLLocationManager) {
        self.shopService = shopService
        self.locationManager = locationManager
        self.isFirstUpdateLocation = true
        super.init()
        self.locationManager.delegate = self
    }
}

extension ShopsInteractor: ShopsInteractorInput {
    func getShops(radius: Double) {
        if isFirstUpdateLocation {
            defferredGetShops = { [weak self, radius] in
                self?.getShops(radius: radius)
            }
            return
        }
        guard let coordinate = locationManager.location?.coordinate else {
            return
        }
        let location = Location(coordinate: coordinate)
        shopService.getShops(location: location, radius: radius) { [weak self] result in
            switch result {
            case .success(let shops):
                self?.output?.didReceiveShops(shops: shops)
            case .failure(let error):
                self?.output?.didReceiveErrorMessage(message: error.localizedDescription)
            }
        }
    }
    
    func requestLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
            return
        }
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation() -> CLLocation? {
        return locationManager.location
    }
    
    func getServices(for shop: Shop) {
        shopService.getServices(shopId: shop.id) { [weak self] result in
            switch result {
            case .success(let servicesDict):
                self?.output?.didReceiveServices(servicesDict: servicesDict)
            case .failure(let error):
                self?.output?.didReceiveErrorMessage(message: error.localizedDescription)
            }
        }
    }
    
    func getReviews(for shopId: Int) {
        shopService.getReviews(shopId: shopId) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.output?.didReceiveReviews(reviews: reviews)
            case .failure(let error):
                self?.output?.didReceiveErrorMessage(message: error.localizedDescription)
            }
        }
    }
    
    func cancelServicesRequest() {
        shopService.cancelRequest()
    }
}

extension ShopsInteractor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first, isFirstUpdateLocation {
            isFirstUpdateLocation = false
            output?.didUpdateLocation(location: location)
            defferredGetShops?()
            defferredGetShops = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
