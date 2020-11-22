//
//  VerifyPresenterInput.swift
//  YourMaster
//
//  Created by Maxim Egorov on 22.09.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

protocol VerifyPresenterInput: AnyObject {
    func configure()
    func finishVerify()
    func showError(message: String)
}
