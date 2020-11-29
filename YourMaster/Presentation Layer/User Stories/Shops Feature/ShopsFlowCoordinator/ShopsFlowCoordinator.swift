

import Foundation
import GoogleMaps

final class ShopsFlowCoordinator {
    weak var mapPresenter: ShopsMapPresenterInput?
    weak var listPresenter: ShopsListPresenter?
    weak var infoPresenter: ShopInfoPresenter?
    var router: ShopsRouterInput?
    var interactor: ShopsInteractorInput?
}

extension ShopsFlowCoordinator: ShopsMapPresenterOutput {
    func didBeginDraggingMap() {
        listPresenter?.setStorkState(state: .dismissed)
    }
    
    func didEndDraggingMap() {
        listPresenter?.setStorkState(state: .middle)
    }
    
    func didRequestShops() {
        interactor?.getShops(radius: 10000)
    }
    
    func didRequestLocation() {
        interactor?.requestLocation()
    }
    
    func setupShopsList() {
        router?.showFloatingPanel()
    }
}

extension ShopsFlowCoordinator: ShopsInteractorOutput {
    func didReceiveShops(shops: [Shop]) {
        mapPresenter?.presentShops(shops: shops)
        listPresenter?.presentShops(shops: shops)
    }
    
    func didReceiveErrorMessage(message: String) {
        mapPresenter?.showErrorMessage(message: message)
        listPresenter?.stopLoadingifNeeded()
    }
    
    func didUpdateLocation(location: CLLocation) {
        mapPresenter?.presentMyLocation(location: location)
    }
}

extension ShopsFlowCoordinator: ShopsListPresenterOutput {
    func didSearch(text: String) {
        mapPresenter?.filterShops(name: text)
    }
    
    func searchDidEnd() {
        mapPresenter?.presentAllShops()
    }
    
    func didRequestPresentMyLocation() {
        if let location = interactor?.getCurrentLocation() {
            mapPresenter?.presentMyLocation(location: location)
        }
    }
    
    func didSelect(shop: Shop) {
        router?.showInfo(shop: shop)
    }
}

extension ShopsFlowCoordinator: CoordinatorInput {
    func start() {
        router?.showMap()
    }
}

extension ShopsFlowCoordinator: ShopInfoPresenterOutput {
    func showDescriptionViewer(description: String) {
        router?.showDescriptionViewer(description: description)
    }
}
