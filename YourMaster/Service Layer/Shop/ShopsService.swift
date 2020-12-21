
import Foundation

final class ShopsService: ShopsServiceProtocol {
    private let networkDispatcher: Dispatcher
    private var currentRequest: Cancellable?

    init(networkDispatcher: Dispatcher) {
        self.networkDispatcher = networkDispatcher
    }
    
    func getShops(location: Location, radius: Double, completion: @escaping ShopCompletion) {
        let request = ShopRequest(location: location, radius: radius)
        currentRequest = networkDispatcher.execute(request: request) { [weak self] result in
            self?.currentRequest = nil
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
            }
        }
    }

    func getServices(shopId: Int, completion: @escaping ServicesCompletion) {
        let request = ServicesRequest(shopId: shopId)
        currentRequest = networkDispatcher.execute(request: request) { [weak self] result in
            self?.currentRequest = nil
            switch result {
            case .success(let response):
                let code = response.statusCode
                if code >= 200 && code <= 299 {
                    guard let servicesDict = try? JSONDecoder().decode([String: [Service]].self, from: response.data) else {
                        completion(Result.failure(AuthorizationError.dataError))
                        return
                    }
                    completion(Result.success(servicesDict))
                }
                if code >= 400 && code <= 499 {
                    completion(Result.failure(AuthorizationError.unauthorized))
                }
                
                if code >= 500 && code <= 599 {
                    completion(Result.failure(AuthorizationError.internalError))
                }
            case .failure(let error):
                completion(Result.failure(AuthorizationError.networkError(error: error)))
            }
        }
    }
    
    func getReviews(shopId: Int, completion: @escaping ReviewsCompletion) {
        let request = ReviewsRequest(shopId: shopId)
        currentRequest = networkDispatcher.execute(request: request) { [weak self] result in
            self?.currentRequest = nil
            switch result {
            case .success(let response):
                let code = response.statusCode
                if code >= 200 && code <= 299 {
                    guard let content = try? JSONDecoder().decode(ReviewResponse.self, from: response.data) else {
                        completion(Result.failure(AuthorizationError.dataError))
                        return
                    }
                    completion(Result.success(content.content))
                }
                if code >= 400 && code <= 499 {
                    completion(Result.failure(AuthorizationError.unauthorized))
                }
                
                if code >= 500 && code <= 599 {
                    completion(Result.failure(AuthorizationError.internalError))
                }
            case .failure(let error):
                completion(Result.failure(AuthorizationError.networkError(error: error)))
            }
        }
    }
    
    func cancelRequest() {
        currentRequest?.cancel()
    }
}
