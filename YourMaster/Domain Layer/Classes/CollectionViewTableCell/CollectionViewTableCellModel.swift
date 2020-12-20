//
//  CollectionViewTableCellModel.swift
//  YourMaster
//
//  Created by Maxim Egorov on 10.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

final class CollectionViewTableCellModel: TableCellModel {
    override var cellIdentifier: String {
        return CollectionViewTableCell.cellIdentifier
    }
    
    override var cellHeight: CGFloat {
        return height
    }
    
    private let height: CGFloat

    var collectionModels: [CollectionCellIdentifiable]
    let cellsForRegistration: [CollectionCell.Type]
    
    init(collectionModels: [CollectionCellIdentifiable],
         height: CGFloat,
         cellsForRegistration: [CollectionCell.Type]) {
        self.collectionModels = collectionModels
        self.height = height
        self.cellsForRegistration = cellsForRegistration
    }
}
