//
//  LoginFeatureRouter.swift
//  YourMaster
//
//  Created by Maxim Egorov on 08.09.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation
import class UIKit.UINavigationController
import class UIKit.UIViewController

protocol LoginFeatureRouterInput {
    func showLogin()
    func showVerifyScene(with phone: String)
}

final class LoginFeatureRouter: LoginFeatureRouterInput {
    weak var navigationController: UINavigationController?
    
    private let assembly: LoginAssemblyProtocol
    
    init(assembly: LoginAssemblyProtocol) {
        self.assembly = assembly
        self.navigationController = UINavigationController.upperNavigationController
    }
    
    func showLogin() {
        DispatchQueue.main.async {
            let loginViewController = self.assembly.loginViewController()
            self.navigationController?.setViewControllers([loginViewController], animated: true)
        }
    }
    
    func showVerifyScene(with phone: String) {
        DispatchQueue.main.async {
            if self.navigationController?.visibleViewController is VerifyViewController { return }
            self.navigationController?.pushViewController(self.assembly.verifyViewController(with: phone), animated: true)
        }
    }
}
