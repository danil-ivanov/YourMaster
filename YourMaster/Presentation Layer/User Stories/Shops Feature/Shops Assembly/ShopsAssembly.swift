
import Foundation
import class CoreLocation.CLLocationManager

protocol ShopsServicesProtocol {
    func shopsService() -> ShopsServiceProtocol
    func locationManager() -> CLLocationManager
}

final class ShopsAssembly {
    private let serviceAssembly: ShopsServicesProtocol
    private let coordinatorAssembly: MenuAssemblyFactoryProtocol & OrderAssemblyFactoryProtocol
    private lazy var shopsService: ShopsServiceProtocol = serviceAssembly.shopsService()
    private lazy var locationManager: CLLocationManager = serviceAssembly.locationManager()
    
    private lazy var flowCoordinator: ShopsFlowCoordinator = {
        let interactor = ShopsInteractor(shopService: shopsService, locationManager: locationManager)
        let router = ShopsRouter(assembly: self)
        let flowCoordinator = ShopsFlowCoordinator(coordinatorAssembly: coordinatorAssembly,
                                                   router: router,
                                                   interactor: interactor)
        interactor.output = flowCoordinator
        return flowCoordinator
    }()
    
    init(coordinatorAssembly: MenuAssemblyFactoryProtocol & OrderAssemblyFactoryProtocol, serviceAssembly: ShopsServicesProtocol) {
        self.coordinatorAssembly = coordinatorAssembly
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
        let presenter = ShopsMapPresenter(output: flowCoordinator)
        let controller = ShopsMapViewController(output: presenter)
        presenter.view = controller
        flowCoordinator.mapPresenter = presenter
        return controller
    }
    
    func shopsListViewController() -> ShopsListViewController {
        let presenter = ShopsListPresenter(output: flowCoordinator)
        let controller = ShopsListViewController(output: presenter)
        presenter.view = controller
        flowCoordinator.listPresenter = presenter
        return controller
    }
    
    func shopInfoViewController(with shop: Shop) -> ShopInfoViewController {
        let presenter = ShopInfoPresenter(shop: shop, output: flowCoordinator)
        let controller = ShopInfoViewController(output: presenter)
        presenter.view = controller
        flowCoordinator.infoPresenter = presenter
        return controller
    }
}
