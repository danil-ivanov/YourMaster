//
//  AppDefaults.swift
//  YourMaster
//
//  Created by Maxim Egorov on 09.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation

enum AppDefaults {
    enum GoogleMaps {
        static let apiKey = "AIzaSyCxbKGyU_ThYOzOibb1G9xURtYZDOHHL08"
        static let styleURL =  Bundle.main.url(forResource: "MapStyle-Light", withExtension: "json")!
    }
    
    enum UserDefaults {
        static let token = "X-Auth-Token"
    }
}
