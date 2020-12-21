
import Foundation

internal typealias ShopCompletion = (Result<[Shop], Error>) -> ()
internal typealias ServicesCompletion = (Result<[String: [Service]], Error>) -> ()
internal typealias ReviewsCompletion = (Result<[Review], Error>) -> ()

protocol ShopsServiceProtocol {
    func getShops(location: Location, radius: Double, completion: @escaping ShopCompletion)
    func getServices(shopId: Int, completion: @escaping ServicesCompletion)
    func getReviews(shopId: Int, completion: @escaping ReviewsCompletion)
    func cancelRequest()
}
