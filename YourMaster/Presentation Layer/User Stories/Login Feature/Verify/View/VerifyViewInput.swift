//
//  VerifyViewInput.swift
//  YourMaster
//
//  Created by Maxim Egorov on 22.09.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

protocol VerifyViewInput: AnyObject {
    func setTitle(title: String)
    func startLoaiding()
    func finishLoading()
    func showError(message: String)
    func hideResendButtonWhenRequest()
}
