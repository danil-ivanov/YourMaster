//
//  MenuViewController.swift
//  YourMaster
//
//  Created by Maxim Egorov on 30.11.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import MessageUI
import UIKit

final class MenuViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
		tableView.separatorStyle = .none
        return tableView
    }()
	
	let dataArr = ["Профиль", "Помощь", "Условия пользования", "Поделиться", "Избранное"]
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = MenuView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupTableView()
		registerTableView()
    }
	
	private func registerTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		tableView.registerCellNib(MenuCell.self)
	}
    
    func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
                                        tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75)])
    }
	
	func open(with url: URL) {
		if UIApplication.shared.canOpenURL(url) {
			if #available(iOS 10.0, *) {
				UIApplication.shared.open(url, options: [:], completionHandler: nil)
			} else {
				UIApplication.shared.openURL(url)
			}
		}
	}
	
	private func sendMail() {
		let subject = "YM"
		let mailTo = "egorov@email.com"
		if MFMailComposeViewController.canSendMail() {
			let mail = MFMailComposeViewController()
			mail.setToRecipients([mailTo])
			mail.mailComposeDelegate = self
			mail.setSubject(subject)
			present(mail, animated: true, completion: nil)
		} else {
			let mailTo = "mailto:\(mailTo)?subject=\(subject)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
			guard let coded = mailTo else { return }
			if let emailURL = URL(string: coded) {
				open(with: emailURL)
			}
		}
	}
	
	func share(sender: UIView) {
		UIGraphicsBeginImageContext(view.frame.size)
		view.layer.render(in: UIGraphicsGetCurrentContext()!)
		UIGraphicsEndImageContext()

		let textToShare = "Check out my app"

		if let myWebsite = URL(string: "https://ihubltd.com/vpn_policy") {//Enter link to your app here
			let objectsToShare = [textToShare, myWebsite] as [Any]
			let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

				//Excluded Activities
			activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
				//

			activityVC.popoverPresentationController?.sourceView = sender
			self.present(activityVC, animated: true, completion: nil)
		}
	}
}

extension MenuViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
		cell.textLabel?.text = dataArr[indexPath.row]
		return cell
	}
}

extension MenuViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.item == 0 {
			let newViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
			self.present(newViewController, animated: true, completion: nil)
			
		} else if indexPath.item == 1 {
			sendMail()
		} else if indexPath.item == 2 {
			open(with: URL(string: "https://ihubltd.com/vpn_policy")!)
		} else if indexPath.item == 3 {
			share(sender: UIView())
		} else if indexPath.item == 4 {
			let newViewController = FavoriteShopViewController(nibName: "FavoriteShopViewController", bundle: nil)
			self.present(newViewController, animated: true, completion: nil)
		}
	}
}

extension MenuViewController: MFMailComposeViewControllerDelegate {

	func mailComposeController(_ controller: MFMailComposeViewController,
							   didFinishWith result: MFMailComposeResult,
							   error: Error?) {
		controller.dismiss(animated: true)
	}

}
