
import Foundation
import class CoreLocation.CLLocationManager

protocol ServiceAssemblyProtocol: LoginServicesProtocol, ShopsServicesProtocol { }

///Контейнер, собирающий сервисы
final class ServiceAssembly {
    private lazy var networkDispatcher: Dispatcher = NetworkDispatcher()
    private lazy var userDefaults: UserDefaultsWrapperProtocol = UserDefaultsWrapper()
}

extension ServiceAssembly: ServiceAssemblyProtocol {
    func authorizationService() -> AuthorizationServiceProtocol {
        return AuthorizationService(networkDispatcher: networkDispatcher, userDefaults: userDefaults)
    }
    
    func shopsService() -> ShopsServiceProtocol {
        return ShopsService(networkDispatcher: networkDispatcher)
    }
    
    func locationManager() -> CLLocationManager {
        return CLLocationManager()
    }
}
