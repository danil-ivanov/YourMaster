//
//  ServiceCollectionCellModel.swift
//  YourMaster
//
//  Created by Maxim Egorov on 10.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

final class ServiceCollectionCellModel: CollectionCellModel {
    
    override var cellIdentifier: String {
        return ServiceCollectionCell.cellIdentifier
    }
    
    override var cellSize: CGSize {
        return CGSize(width: 150, height: 100)
    }
    
    let name: String
    let price: Float
    
    init(name: String, price: Float) {
        self.name = name
        self.price = price
    }
}
