//
//  ServicesViewController.swift
//  YourMaster
//
//  Created by Maxim Egorov on 04.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

protocol ServicesViewOutput: AnyObject {
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func configure()
    func configure(_ cell: TableCell, at row: Int, in section: Int)
    func configure(_ view: TableSection, in section: Int)
    func didRequestServices()
    func viewDidClose()
    func search(_ text: String)
}

final class ServicesViewController: UIViewController {
    
    private let output: ServicesViewOutput
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: CGFloat.leastNormalMagnitude))
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(output: ServicesViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.didRequestServices()
        output.configure()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        output.viewDidClose()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }

    private func setupNavigationItem() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func registerCollectionView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCellClass(CollectionViewTableCell.self)
        tableView.registerHeaderFooterViewClass(StandardTextSection.self)
    }
}

extension ServicesViewController: ServicesViewInput {
    func prepareInterface() {
        navigationItem.title = "Услуги и цены"
        //setupNavigationItem()
        setupViews()
        registerCollectionView()
    }

    func presentServices() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func startLoading() {
        view.startLoader()
    }

    func finishLoading() {
        DispatchQueue.main.async {
            self.view.stopLoader()
        }
    }
}

extension ServicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRows(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableCell.cellIdentifier,
                                                       for: indexPath) as? TableCell else {
            return UITableViewCell()
        }
        output.configure(cell, at: indexPath.row, in: indexPath.section)
        return cell
    }
}

extension ServicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: StandardTextSection.cellIdentifier) as? TableSection else {
            return UIView()
        }
        output.configure(header, in: section)
        return header
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        navigationItem.hidesSearchBarWhenScrolling = true
    }
}

extension ServicesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else {
            return
        }
        output.search(text)
    }
}
