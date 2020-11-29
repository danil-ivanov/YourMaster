

import Foundation

struct AuthorizationRequest: Request {
    let number: String
    var path: String = "otp/request"
    
    var method: HTTPMethod = .get
    
    var parameters: RequestParameters {
        return .url(["phone": number])
    }
    
    init(with number: String) {
        self.number = number
    }
}
