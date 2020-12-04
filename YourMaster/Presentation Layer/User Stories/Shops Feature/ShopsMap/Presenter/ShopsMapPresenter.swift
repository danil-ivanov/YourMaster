
import Foundation
import GoogleMapsUtils
import class CoreLocation.CLLocation

protocol ShopsMapPresenterOutput: AnyObject {
    func didRequestShops()
    func didRequestLocation()
    func didBeginDraggingMap()
    func didEndDraggingMap()
    func setupShopsList()
}

final class ShopsMapPresenter {
    weak var view: ShopsMapViewInput?
    private let output: ShopsMapPresenterOutput?
    
    private var clusterManager: ClusterManager
    
    init(output: ShopsMapPresenterOutput) {
        self.output = output
        self.clusterManager = ClusterManager()
    }
}

extension ShopsMapPresenter: ShopsMapPresenterInput {
    func presentMyLocation(location: CLLocation) {
        view?.presentMyLocation(location: location)
    }
    
    func presentShops(shops: [Shop]) {
        let items: [ClusterItem] = shops.map{ ClusterItem(position: $0.getPosition(), name: $0.name) }
        DispatchQueue.main.async {
            self.clusterManager.addItems(items)
        }
    }
    
    func showErrorMessage(message: String) {
        view?.showErrorMessage(message: message)
    }
    
    func filterShops(name: String) {
        clusterManager.search(text: name)
    }
    
    func presentAllShops() {
        clusterManager.renderAllMarkers()
    }
}

extension ShopsMapPresenter: ShopsMapViewOutput {
    func viewDidLoad(mapView: GMSMapView, mapDelegate: GMSMapViewDelegate & GMUClusterManagerDelegate) {
        clusterManager.setup(mapView: mapView, mapDelegate: mapDelegate)
        view?.prepareInterface()
    }
    
    func didBeginDraggingMap() {
        output?.didBeginDraggingMap()
    }
    
    func didEndDraggingMap() {
        output?.didEndDraggingMap()
    }
    
    func didRequestShops() {
        output?.didRequestShops()
    }
    
    func didRequestLocation() {
        output?.didRequestLocation()
    }
    
    func setupShopsList() {
        output?.setupShopsList()
    }
}
