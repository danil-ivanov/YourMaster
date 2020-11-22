//
//  UICollectionView+registerCellClass.swift
//  YourMaster
//
//  Created by Maxim Egorov on 29.10.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        
        self.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
}
