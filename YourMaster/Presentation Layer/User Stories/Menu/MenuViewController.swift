//
//  MenuViewController.swift
//  YourMaster
//
//  Created by Maxim Egorov on 30.11.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
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
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
                                        tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75)])
    }
}
