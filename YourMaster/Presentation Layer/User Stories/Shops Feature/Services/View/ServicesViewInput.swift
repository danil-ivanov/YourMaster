//
//  ServicesViewInput.swift
//  YourMaster
//
//  Created by Maxim Egorov on 04.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

protocol ServicesViewInput: AnyObject {
    func prepareInterface()
    func presentServices()
    func startLoading()
    func finishLoading()
}
