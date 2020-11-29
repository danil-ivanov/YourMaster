
import Foundation

final class ShopsService: ShopsServiceProtocol {
    let networkDispatcher: Dispatcher
    
    init(networkDispatcher: Dispatcher) {
        self.networkDispatcher = networkDispatcher
    }
    
    func getShops(location: Location, radius: Double, completion: @escaping ShopCompletion) {
        let request = ShopRequest(location: location, radius: radius)
        networkDispatcher.execute(request: request) { result in
            switch result {
            case .success(let response):
                let code = response.statusCode
                if code >= 200 && code <= 299 {
                    guard let shops = try? JSONDecoder().decode([Shop].self, from: response.data) else {
                        return
                    }
                    completion(Result.success(shops))
                    return
                }
                if code >= 400 && code <= 499 {
                    completion(Result.failure(AuthorizationError.unauthorized))
                }
                
                if code >= 500 && code <= 599 {
                    completion(Result.failure(AuthorizationError.internalError))
                }
            case .failure(let error):
                completion(Result.failure(AuthorizationError.networkError(error: error)))
                break
            }
        }
    }
}
