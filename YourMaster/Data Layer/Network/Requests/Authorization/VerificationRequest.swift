

import Foundation

struct VerficationRequest: Request {
    let code: String
    let phone: String
    var path: String = "otp/verify"
    
    var method: HTTPMethod = .get
    
    var parameters: RequestParameters {
        return .url(["code": code, "phone": phone])
    }
    
    init(code: String, phone: String) {
        self.code = code
        self.phone = phone
    }
}
