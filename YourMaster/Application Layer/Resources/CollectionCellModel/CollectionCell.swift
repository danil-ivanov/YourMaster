//
//  CollectionCell.swift
//  YourMaster
//
//  Created by Maxim Egorov on 29.10.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

open class CollectionCell: UICollectionViewCell, TableCellRepresentable {
    
    // MARK: - Identifier
    class public var cellIdentifier: String {
        return String.className(self)
    }
    
    // MARK: - Props
    public var model: TableCellIdentifiable? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Initialization
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    // MARK: - Setup functions
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    open func setupView() { }
    
    open func updateViews() { }
    
    open func setHighlighted() { }
    
    open func setSelected() { }
}
