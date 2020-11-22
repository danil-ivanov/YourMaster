//
//  HTTPMethod.swift
//  network-app
//
//  Created by Maxim Egorov on 06.07.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation

// Типы запросов к серверу

public enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
}
