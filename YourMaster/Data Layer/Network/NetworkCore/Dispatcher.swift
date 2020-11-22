//
//  Dispatcher.swift
//  network-app
//
//  Created by Maxim Egorov on 06.07.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation

internal typealias NetworkDispatcherCompletion = (_ networkResult: Result<DispatcherResponse, NetworkError>) -> ()

// Протокол, описывающий запросы к сети. Можно использововать как с URLSession,
// так в случае необходимости и с Alamofire

internal protocol Dispatcher: class {
    
    // Выполнение запроса к сети, с параметром Request и escaping блок, содержащий данные,
    // либо ошибку
    
    @discardableResult
    func execute(request: Request, completion: @escaping NetworkDispatcherCompletion) -> Cancellable
}
