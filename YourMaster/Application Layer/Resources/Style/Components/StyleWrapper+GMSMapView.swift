//
//  StyleWrapper+GMSMapView.swift
//  YourMaster
//
//  Created by Maxim Egorov on 22.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

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
