//
//  BasicRouter.swift
//  YourMaster
//
//  Created by Maxim Egorov on 13.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation
import UIKit

public protocol BasicRouterInput: AnyObject {
    var viewController: UIViewController? { get set }
    func setRootViewController(_ viewController: UIViewController)
    
    func dismiss(animated: Bool)
    func goBack(animated: Bool)
    func goToRoot(animated: Bool)
    func showError(_ error: Error?)
    func showError(message: String?)
    func showAlert(title: String, message: String?)
    func showActionSheet(title: String, message: String?)
}

extension BasicRouterInput {
    
    // MARK: - ViperRouterInputProtocol
    public func setRootViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    public func dismiss(animated: Bool) {
        DispatchQueue.main.async {
            self.viewController?.dismiss(animated: animated, completion: nil)
        }
    }
    
    public func goBack(animated: Bool) {
        DispatchQueue.main.async {
            self.viewController?.navigationController?.popViewController(animated: animated)
        }
    }
    
    public func goToRoot(animated: Bool) {
        DispatchQueue.main.async {
            self.viewController?.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    public func showError(_ error: Error?) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "Error", style: .cancel)
            alert.addAction(action)
            self?.viewController?.present(alert, animated: true)
        }
    }
    
    public func showError(message: String?) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Error", style: .cancel)
            alert.addAction(action)
            self?.viewController?.present(alert, animated: true)
        }
    }
    
    public func showAlert(title: String, message: String?) {
           DispatchQueue.main.async { [weak self] in
               let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
               let action = UIAlertAction(title: "Ok", style: .cancel)
               alert.addAction(action)
               self?.viewController?.present(alert, animated: true)
           }
       }
    
    func showActionSheet(title: String, message: String?) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            self?.viewController?.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Module functions
    func present(_ viewController: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.viewController?.present(viewController, animated: animated, completion: nil)
        }
    }
    
    func push(to viewController: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.viewController?.navigationController?.pushViewController(viewController, animated: animated)
        }
    }
        
}
