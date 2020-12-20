
import Foundation

internal typealias ShopCompletion = (Result<[Shop], Error>) -> ()
internal typealias ServicesCompletion = (Result<[String: [Service]], Error>) -> ()

protocol ShopsServiceProtocol {
    func getShops(location: Location, radius: Double, completion: @escaping ShopCompletion)
    func getServices(shopId: Int, completion: @escaping ServicesCompletion)
    func cancelRequest()
}
