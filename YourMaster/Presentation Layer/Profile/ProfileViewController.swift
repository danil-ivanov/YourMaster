//
//  ProfileViewController.swift
//  YourMaster
//
//  Created by Александр Пономарёв on 03.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
	@IBOutlet var emailButton: UIButton!
	@IBOutlet var nameButton: UIButton!
	@IBOutlet var numberButton: UIButton!
	@IBOutlet var avatarImage: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.avatarImage.layer.cornerRadius = self.avatarImage.frame.height / 2
		let name = UserDefaults.standard.string(forKey: "name") ?? "Ваше имя"
		let email = UserDefaults.standard.string(forKey: "email") ?? "Ваша почта"
		numberButton.setTitle(AppShared.storage.user?.phone, for: .normal)
		nameButton.setTitle(name, for: .normal)
		emailButton.setTitle(email, for: .normal)
	}
	
	@IBAction func inputNameAction(_ sender: Any) {
		let alert = UIAlertController(title: "Введите имя", message: "", preferredStyle: .alert)
		alert.addTextField { (textField) in
			textField.placeholder = "Введите ваше имя"
		}
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
			let textField = alert?.textFields![0]
			self.nameButton.setTitle(textField?.text, for: .normal)
			UserDefaults.standard.setValue(textField?.text, forKey: "name")
		}))
		self.present(alert, animated: true, completion: nil)
	}
	
	@IBAction func inputNumberAction(_ sender: Any) { }
	
	@IBAction func inputEmailAction(_ sender: Any) {
		let alert = UIAlertController(title: "Введите почту", message: "Для получения уведомлений о спецпредложениях", preferredStyle: .alert)
		alert.addTextField { (textField) in
			textField.placeholder = "Введите вашу почту"
		}
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
			let textField = alert?.textFields![0]
			self.emailButton.setTitle(textField?.text, for: .normal)
			UserDefaults.standard.setValue(textField?.text, forKey: "email")
		}))
		self.present(alert, animated: true, completion: nil)
	}
	
	@IBAction func logoutAction(_ sender: Any) {
		
	}
}
