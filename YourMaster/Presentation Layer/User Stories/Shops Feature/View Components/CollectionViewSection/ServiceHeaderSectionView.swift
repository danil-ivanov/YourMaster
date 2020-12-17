//
//  ServiceHeaderSectionView.swift
//  YourMaster
//
//  Created by Maxim Egorov on 10.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

final class ServiceHeaderSectionView: CollectionSection {
    override class var cellIdentifier: String {
        return String.className(self)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = SFUIDisplay.bold.font(size: 20)
        label.numberOfLines = 1
        return label
    }()
    
    override func setupView() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)])
    }
    
    override func updateViews() {
        guard let model = self.model as? ServiceHeaderSectionViewModel else {
            return
        }
        titleLabel.text = model.title
    }
}
