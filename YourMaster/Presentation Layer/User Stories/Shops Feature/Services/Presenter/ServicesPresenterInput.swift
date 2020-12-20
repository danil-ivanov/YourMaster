//
//  ServicesPresenterInput.swift
//  YourMaster
//
//  Created by Maxim Egorov on 04.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

protocol ServicesPresenterInput: AnyObject {
    func updateServices(servicesDict: [String: [Service]])
}
