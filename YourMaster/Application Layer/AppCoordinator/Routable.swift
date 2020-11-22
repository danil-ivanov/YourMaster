//
//  Routable.swift
//  YourMaster
//
//  Created by Maxim Egorov on 10.09.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

protocol Routable {
    associatedtype ScreenType
    func route(to screen: ScreenType)
}
