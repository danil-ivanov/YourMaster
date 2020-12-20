

import Foundation
import GoogleMaps

final class ShopsFlowCoordinator {
    weak var mapPresenter: ShopsMapPresenterInput?
    weak var listPresenter: ShopsListPresenter?
    weak var infoPresenter: ShopInfoPresenter?
    weak var servicesPresenter: ServicesPresenterInput?
    private let router: ShopsRouterInput
    private let interactor: ShopsInteractorInput
    
    private let coordinatorAssembly: MenuAssemblyFactoryProtocol & OrderAssemblyFactoryProtocol
    
    private var orderFlowCoordinator: (CoordinatorInput & OrderFlowCoordinatorOutput)?
    
    init(coordinatorAssembly: MenuAssemblyFactoryProtocol & OrderAssemblyFactoryProtocol,
         router: ShopsRouterInput,
         interactor: ShopsInteractorInput) {
        self.coordinatorAssembly = coordinatorAssembly
        self.router = router
        self.interactor = interactor
    }
}

extension ShopsFlowCoordinator: ShopsMapPresenterOutput {
    func didBeginDraggingMap() {
        listPresenter?.setStorkState(state: .dismissed)
    }
    
    func didEndDraggingMap() {
        listPresenter?.setStorkState(state: .middle)
    }
    
    func didRequestShops() {
        interactor.getShops(radius: 10000000)
    }
    
    func didRequestLocation() {
        interactor.requestLocation()
    }
    
    func setupShopsList() {
        router.showFloatingPanel()
        coordinatorAssembly.createMenuAssembly().coordinator().start()
    }
}

extension ShopsFlowCoordinator: ShopsInteractorOutput {
    func didReceiveShops(shops: [Shop]) {
        mapPresenter?.presentShops(shops: shops)
        listPresenter?.presentShops(shops: shops)
    }
    
    func didReceiveServices(servicesDict: [String: [Service]]) {
        servicesPresenter?.updateServices(servicesDict: servicesDict)
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
        if let location = interactor.getCurrentLocation() {
            mapPresenter?.presentMyLocation(location: location)
        }
    }
    
    func didSelect(shop: Shop) {
        router.showInfo(shop: shop)
    }
}

extension ShopsFlowCoordinator: CoordinatorInput {
    func start() {
        router.showMap()
    }
}

extension ShopsFlowCoordinator: ShopInfoPresenterOutput {
    func showDescriptionViewer(description: String) {
        router.showDescriptionViewer(description: description)
    }
    
    func showPhotosViewer() {
        
    }
    
    func showReviewsView() {
        
    }
    
    func showServices(of shop: Shop) {
        router.showServices(of: shop)
    }
}

extension ShopsFlowCoordinator: ServicesPresenterOutput {

    func didRequestServices(shop: Shop) {
        interactor.getServices(for: shop)
    }

    func servicesDidClose() {
        interactor.cancelServicesRequest()
    }
}
