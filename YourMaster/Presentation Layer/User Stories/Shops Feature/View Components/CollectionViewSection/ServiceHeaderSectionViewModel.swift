//
//  ServiceHeaderSectionViewModel.swift
//  YourMaster
//
//  Created by Maxim Egorov on 10.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

final class ServiceHeaderSectionViewModel: CollectionSectionModel {
    override var headerIdentifier: String {
        ServiceHeaderSectionView.cellIdentifier
    }
    
    let title: String
    
    init(title: String, headHeight: CGFloat) {
        self.title = title
        super.init(headHeight: headHeight)
    }
}
