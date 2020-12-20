//
//  CollectionSection.swift
//  YourMaster
//
//  Created by Maxim Egorov on 10.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit


open class CollectionSection: UICollectionReusableView, SectionRepresentable {
    
    class public var cellIdentifier: String {
        return String.className(self)
    }
    
    var model: SectionIdentifiable? {
        didSet {
            updateViews()
        }
    }
    
    var rows: [CollectionCellIdentifiable] = []
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    open func setupView() { }
    
    open func updateViews() { }
    
}
