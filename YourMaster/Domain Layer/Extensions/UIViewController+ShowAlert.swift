//
//  UIViewController+ShowAlert.swift
//  YourMaster
//
//  Created by Maxim Egorov on 23.09.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

extension UIViewController {
    func showErrorAlert(message: String) {
        DispatchQueue.main.async {
            ImpactFeedbackGenerator.impactOccured()
            let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
}
