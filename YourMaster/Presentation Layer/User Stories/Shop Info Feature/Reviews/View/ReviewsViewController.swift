//
//  ReviewsViewController.swift
//  YourMaster
//
//  Created by Maxim Egorov on 19.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

protocol ReviewsViewOutput: TableViewOutput {
    func configure()
    func didRequestReviews()
}

final class ReviewsViewController: UIViewController {
    
    private let output: ReviewsViewOutput
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    init(output: ReviewsViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.configure()
        output.didRequestReviews()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerHeaderFooterViewClass(StandardTextSection.self)
        tableView.registerCellClass(ReviewCell.self)
    }
}

extension ReviewsViewController: ReviewsViewInput {
    func prepareInterface() {
        view.backgroundColor = .white
        navigationItem.title = "Отзывы"
        setupViews()
    }
    
    func presentReviews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ReviewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = output.identifierForCell(at: indexPath.row, in: indexPath.section)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TableCell else {
            return UITableViewCell()
        }
        output.configure(cell: cell, at: indexPath.row, in: indexPath.section)
        return cell
    }
}

extension ReviewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return output.heightForHeader(in: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: StandardTextSection.cellIdentifier) as? TableSection else {
            return UIView()
        }
        output.congigure(header: header, in: section)
        return header
    }
}
