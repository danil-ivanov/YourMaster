
import Foundation
import GoogleMaps

struct Shop {
    struct Contacts {
        let instagramUrl: String
        let phone: String
    }
    
    struct Location {
        let address: String
        let latitude: Double
        let longitude: Double
    }
    
    struct Rating {
        let average: Int
        let bad: Int
        let excellent: Int
        let good: Int
        let terrible: Int
        let total: Int
    }
    
    let id: Int
    let name: String
    let contacts: Contacts
    let location: Location
    let rating: Rating
    
    func getPosition() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
    
    func getDistance(from userLocation: CLLocation) -> Float {
        return Float(CLLocation(latitude: location.latitude,
                                longitude: location.longitude)
            .distance(from: userLocation))
    }
}

extension Shop: Codable {}
extension Shop.Contacts: Codable {}
extension Shop.Location: Codable {}
extension Shop.Rating: Codable {}
