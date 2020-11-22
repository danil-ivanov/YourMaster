//
//  LoginRequest.swift
//  YourMaster
//
//  Created by Maxim Egorov on 11.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

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
