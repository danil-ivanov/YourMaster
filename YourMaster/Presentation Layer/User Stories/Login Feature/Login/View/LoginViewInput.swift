//
//  LoginViewInput.swift
//  YourMaster
//
//  Created by Maxim Egorov on 22.09.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

protocol LoginViewInput: AnyObject {
    func startLoaiding()
    func finishLoading()
    func showError(message: String)
}
