//
//  ServicesRequest.swift
//  YourMaster
//
//  Created by Maxim Egorov on 10.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

struct ServicesRequest: Request {
    var path: String = "services"
    
    var method: HTTPMethod = .get
    
    var parameters: RequestParameters {
        .url(["shop_id": shopId])
    }
    
    var headers: [String : String] {
        return [AppDefaults.UserDefaults.token: AppShared.storage.token ?? ""]
    }
    
    let shopId: Int
}
