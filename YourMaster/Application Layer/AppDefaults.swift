
import Foundation

enum AppDefaults {
    enum GoogleMaps {
        static let apiKey = "AIzaSyCxbKGyU_ThYOzOibb1G9xURtYZDOHHL08"
        static let styleURL =  Bundle.main.url(forResource: "MapStyle-Light", withExtension: "json")!
    }
    
    enum UserDefaults {
        static let token = "X-Auth-Token"
        static let user = "currentUser"
    }
}
