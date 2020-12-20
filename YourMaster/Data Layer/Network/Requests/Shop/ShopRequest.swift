

import Foundation

struct ShopRequest: Request {

    var path: String = "shops"
    
    var method: HTTPMethod = .get
    
    var parameters: RequestParameters {
        .url(["latitude": location.latitude, "longitude": location.longitude, "radius": radius])
    }
    
    var headers: [String: String] {
        return [AppDefaults.UserDefaults.token: AppShared.storage.token ?? ""]
    }
    
    let location: Location
    let radius: Double
    
}
