//
//  CollectionSectionModel.swift
//  YourMaster
//
//  Created by Maxim Egorov on 10.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

protocol CollectionSectionIdentifiable: SectionIdentifiable {
    var cellModels: [CollectionCellIdentifiable] { get set }
}

open class CollectionSectionModel: CollectionSectionIdentifiable {
    var footerHeight: CGFloat {
        return footHeight
    }
    
    var cellModels: [CollectionCellIdentifiable]
    
    var headerIdentifier: String {
        return ""
    }
    
    var headerHeight: CGFloat {
        return headHeight
    }
    
    private let headHeight: CGFloat
    private let footHeight: CGFloat
    
    init(headHeight: CGFloat, footHeight: CGFloat = 0) {
        self.headHeight = headHeight
        self.footHeight = footHeight
        self.cellModels = []
    }
}
