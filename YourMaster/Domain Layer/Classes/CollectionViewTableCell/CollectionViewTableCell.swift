//
//  CollectionViewTableCell.swift
//  YourMaster
//
//  Created by Maxim Egorov on 10.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

final class CollectionViewTableCell: TableCell {
    override class var cellIdentifier: String {
        return String.className(self)
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var collectionViewModel: CollectionViewTableCellModel? {
        return model as? CollectionViewTableCellModel
    }
    
    override func setupView() {
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func updateViews() {
        guard let model = collectionViewModel else {
            return
        }
        collectionView.heightAnchor.constraint(equalToConstant: model.cellHeight).isActive = true
        model.cellsForRegistration.forEach {
            collectionView.registerCellClass($0)
        }
    }
}

extension CollectionViewTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewModel?.collectionModels.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellModel = collectionViewModel?.collectionModels[indexPath.row],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.cellIdentifier, for: indexPath) as? CollectionCell else {
            return UICollectionViewCell()
        }
        cell.model = cellModel
        return cell
    }
}

extension CollectionViewTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionViewModel?.collectionModels[indexPath.row].cellSize ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
