//
//  FavoriteShopViewController.swift
//  YourMaster
//
//  Created by Александр Пономарёв on 20.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

class FavoriteShopViewController: UIViewController {
	@IBOutlet var tableView: UITableView!
	var shops = [Shop]()
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.tableFooterView = UIView()
		tableView.registerCellNib(ShopCell.self)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		if let data = UserDefaults.standard.value(forKey:"favShops") as? Data {
			self.shops = try! PropertyListDecoder().decode(Array<Shop>.self, from: data)
			self.tableView.reloadData()
		}
		setupTableView()
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		if let data = UserDefaults.standard.value(forKey:"favShops") as? Data {
			var shops = try? PropertyListDecoder().decode(Array<Shop>.self, from: data)
			shops = self.shops
			UserDefaults.standard.set(try? PropertyListEncoder().encode(shops), forKey:"favShops")
		} else {
			UserDefaults.standard.set(try? PropertyListEncoder().encode(self.shops), forKey:"favShops")
		}
	}
}

extension FavoriteShopViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return shops.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: ShopCell.cellIdentifier) as? ShopCell else {
			return UITableViewCell()
		}
		let shopsCellModels = shops.map{ ShopCellModel(imagePath: "", shopName: $0.name, shopAdress: $0.location.address) }
		cell.model = shopsCellModels[indexPath.row]
		return cell
	}
}
