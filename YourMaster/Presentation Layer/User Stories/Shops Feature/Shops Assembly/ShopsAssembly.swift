
import Foundation
import class CoreLocation.CLLocationManager

protocol ShopsServicesProtocol {
    func shopsService() -> ShopsServiceProtocol
    func locationManager() -> CLLocationManager
}

final class ShopsAssembly {
    var serviceAssembly: ShopsServicesProtocol
    private lazy var shopsService: ShopsServiceProtocol = serviceAssembly.shopsService()
    private lazy var locationManager: CLLocationManager = serviceAssembly.locationManager()
    
    private lazy var flowCoordinator: ShopsFlowCoordinator = {
        let flowCoordinator = ShopsFlowCoordinator()
        let interactor = ShopsInteractor(shopService: shopsService, locationManager: locationManager)
        let router = ShopsRouter(assembly: self)
        flowCoordinator.router = router
        flowCoordinator.interactor = interactor
        interactor.output = flowCoordinator
        return flowCoordinator
    }()
    
    init(serviceAssembly: ShopsServicesProtocol) {
        self.serviceAssembly = serviceAssembly
    }
    
    func featureFlowCoordinator() -> CoordinatorInput {
        return flowCoordinator
    }
}

extension ShopsAssembly: ShopsFlowCoordinatorAssemblyProtocol {
    func coordinator() -> CoordinatorInput {
        return flowCoordinator
    }
}

extension ShopsAssembly: ShopsAssemblyProtocol {
    func shopsMapViewController() -> ShopsMapViewController {
        let presenter = ShopsMapPresenter()
        let controller = ShopsMapViewController()
        controller.output = presenter
        presenter.output = flowCoordinator
        presenter.view = controller
        flowCoordinator.mapPresenter = presenter
        return controller
    }
    
    func shopsListViewController() -> ShopsListViewController {
        let presenter = ShopsListPresenter()
        let controller = ShopsListViewController()
        controller.output = presenter
        presenter.view = controller
        presenter.output = flowCoordinator
        flowCoordinator.listPresenter = presenter
        return controller
    }
    
    func shopInfoViewController(with shop: Shop) -> ShopInfoViewController {
        let presenter = ShopInfoPresenter(shop: shop)
        let controller = ShopInfoViewController()
        controller.output = presenter
        presenter.view = controller
        flowCoordinator.infoPresenter = presenter
        presenter.output = flowCoordinator
        return controller
    }
}
