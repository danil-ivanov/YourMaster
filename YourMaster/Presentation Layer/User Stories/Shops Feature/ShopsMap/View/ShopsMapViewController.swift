

import Foundation
import UIKit
import GoogleMaps
import GoogleMapsUtils

protocol ShopsMapViewOutput: AnyObject {
    func viewDidLoad(mapView: GMSMapView, mapDelegate: GMUClusterManagerDelegate & GMSMapViewDelegate)
    func didRequestShops()
    func didRequestLocation()
    func didBeginDraggingMap()
    func didEndDraggingMap()
    func setupShopsList()
}

final class ShopsMapViewController: UIViewController {
    private let output: ShopsMapViewOutput
    
    private lazy var mapView: GMSMapView = {
        return GMSMapView(frame: view.bounds)
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "Поиск"
        return searchBar
    }()
    
    private var maxZoom: Float = 0
    
    init(output: ShopsMapViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad(mapView: mapView, mapDelegate: self)
        mapView.delegate = self
        output.didRequestLocation()
        output.didRequestShops()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if children.contains(where: { $0 is ShopsListViewController }) {
            return
        }
        output.setupShopsList()
    }
    
    private func applyStyles() {
        //mapView.apply(.mainMap())
    }
}

extension ShopsMapViewController: ShopsMapViewInput {
    func prepareInterface() {
        view.addSubview(mapView)
        navigationController?.setNavigationBarHidden(true, animated: true)
        applyStyles()
    }
    
    func presentMyLocation(location: CLLocation) {
        DispatchQueue.main.async {
            self.mapView.isMyLocationEnabled = true
            self.mapView.animate(to: GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0))
            self.maxZoom = 15
        }
    }
    
    func startLoading() {
        view.startLoader()
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.view.stopLoader()
        }
    }
    
    func showErrorMessage(message: String) {
        self.showErrorAlert(message: message)
    }
}

extension ShopsMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if gesture {
            output.didBeginDraggingMap()
        }
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        output.didEndDraggingMap()
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let zoom = position.zoom
    }
}

extension ShopsMapViewController: GMUClusterManagerDelegate {
    func clusterManager(_ clusterManager: GMUClusterManager, didTap clusterItem: GMUClusterItem) -> Bool {
        return true
    }
}
