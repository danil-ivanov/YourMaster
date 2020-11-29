
import Foundation
import GoogleMapsUtils

protocol ShopsInteractorOutput: AnyObject {
    func didReceiveShops(shops: [Shop])
    func didReceiveErrorMessage(message: String)
    func didUpdateLocation(location: CLLocation)
}

final class ShopsInteractor: NSObject {
    private let shopService: ShopsServiceProtocol
    private let locationManager: CLLocationManager
    
    weak var output: ShopsInteractorOutput?
    
    private var isFirstUpdateLocation: Bool
    
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
            locationManager.requestLocation()
            return
        }
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation() -> CLLocation? {
        return locationManager.location
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
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
