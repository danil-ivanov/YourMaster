
import Foundation

// Способы передачи параметров серверу

public enum RequestParameters {
    
    // В теле запроса
    
    case body(_ : [String: Any]?)
    
    // В URL
    
    case url(_ : [String: Any]?)
}
