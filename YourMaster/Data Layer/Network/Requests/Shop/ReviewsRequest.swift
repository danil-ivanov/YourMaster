//
//  ReviewsRequest.swift
//  YourMaster
//
//  Created by Maxim Egorov on 20.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

struct ReviewsRequest: Request {
    var parameters: RequestParameters {
        return .url([:])
    }
    
    var path: String = "shops"
    
    var method: HTTPMethod = .get
    
    
    
    var headers: [String : String] {
        return [AppDefaults.UserDefaults.token: AppShared.storage.token ?? ""]
    }
    
    let shopId: Int
    
    init(shopId: Int) {
        self.shopId = shopId
        path.append("/\(shopId)")
        path.append("/comments")
    }
}
