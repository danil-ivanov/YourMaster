
import Foundation
import UIKit
import GoogleMaps

extension StyleWrapper where Element: GMSMapView {
    static func mainMap() -> StyleWrapper {
        return .wrap { mapView in
            mapView.isMyLocationEnabled = true
            //mapView.settings.myLocationButton = true
            mapView.mapStyle = try? .init(contentsOfFileURL: AppDefaults.GoogleMaps.styleURL)
        }
    }
}
