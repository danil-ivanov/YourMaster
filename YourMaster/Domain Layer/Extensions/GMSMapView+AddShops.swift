
import Foundation
import UIKit
import GoogleMaps

extension GMSMapView {
    func addShops(_ shops: [Shop]) {
        shops.forEach { shop in
            let marker = GMSMarker(position: shop.getPosition())
            marker.isDraggable = true
            marker.isTappable = true
            marker.map = self
        }
    }
}
