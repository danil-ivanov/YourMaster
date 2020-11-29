
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
    
    let id: Int
    let name: String
    let contacts: Contacts
    let location: Location
    
    func getPosition() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
}

extension Shop: Decodable {}
extension Shop.Contacts: Decodable {}
extension Shop.Location: Decodable {}
