
import Foundation

protocol ShopsAssemblyProtocol {
    func shopsMapViewController() -> ShopsMapViewController
    func shopsListViewController() -> ShopsListViewController
    func shopInfoViewController(with shop: Shop) -> ShopInfoViewController
    func shopServicesController(with shop: Shop) -> ServicesViewController
}

///Протокол сущности, которая собирает коордиантор
protocol ShopsFlowCoordinatorAssemblyProtocol {
    
    ///собрать координатор
    func coordinator() -> CoordinatorInput
}

///протокол для сборки assembly на фабрике
protocol ShopsAssemblyFactoryProtocol {
    
    ///собрать assembly
    func createShopsAssembly() -> ShopsFlowCoordinatorAssemblyProtocol
}
