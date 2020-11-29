

import Foundation
import GoogleMaps

struct Location {
    let latitude: Double
    let longitude: Double
    
    init(coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude.advanced(by: 0)
        self.longitude = coordinate.longitude.advanced(by: 0)
    }
}
