//
//  VerificationRequest.swift
//  YourMaster
//
//  Created by Maxim Egorov on 14.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

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
