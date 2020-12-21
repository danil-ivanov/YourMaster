//
//  Review.swift
//  YourMaster
//
//  Created by Maxim Egorov on 20.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//


struct ReviewResponse: Decodable {
    let content: [Review]
}

struct Review: Codable {
    let user: User
    let message: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case user = "customer"
        case message
        case rating
    }
}

