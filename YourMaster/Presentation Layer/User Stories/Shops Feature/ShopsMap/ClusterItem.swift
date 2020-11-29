

import Foundation
import GoogleMapsUtils

class ClusterItem: NSObject, GMUClusterItem {
  var position: CLLocationCoordinate2D
  var name: String

  init(position: CLLocationCoordinate2D, name: String) {
    self.position = position
    self.name = name
  }
}
