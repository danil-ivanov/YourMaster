

import Foundation

struct ShopRequest: Request {
    var path: String = "shops"
    
    var method: HTTPMethod = .get
    
    var parameters: RequestParameters {
        .url(["latitude": location.latitude, "longitude": location.longitude, "radius": radius])
    }
    
    var headers: [String: String] {
        let token = UserDefaults.standard.string(forKey: AppDefaults.UserDefaults.token)
        return [AppDefaults.UserDefaults.token: token ?? ""]
    }
    
    let location: Location
    let radius: Double
    
}
