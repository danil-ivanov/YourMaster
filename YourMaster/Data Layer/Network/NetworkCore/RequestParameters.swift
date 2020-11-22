//
//  RequestParameters.swift
//  network-app
//
//  Created by Maxim Egorov on 06.07.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation

// Способы передачи параметров серверу

public enum RequestParameters {
    
    // В теле запроса
    
    case body(_ : [String: Any]?)
    
    // В URL
    
    case url(_ : [String: Any]?)
}
