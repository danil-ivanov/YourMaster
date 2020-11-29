
import Foundation

internal typealias ShopCompletion = (Result<[Shop], Error>) -> ()

protocol ShopsServiceProtocol {
    func getShops(location: Location, radius: Double, completion: @escaping ShopCompletion)
}
