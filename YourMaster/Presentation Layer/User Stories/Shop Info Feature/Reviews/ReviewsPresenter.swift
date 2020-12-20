//
//  ReviewsPresenter.swift
//  YourMaster
//
//  Created by Maxim Egorov on 19.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

protocol ReviewsPresenterOutput: AnyObject {
    func didRequestReviews()
}

final class ReviewsPresenter {
    
    weak var view: ReviewsViewInput?
    
    private let output: ReviewsPresenterOutput
    private var sectionModels: [TableSectionModel]

    init(output: ReviewsPresenterOutput) {
        self.output = output
        self.sectionModels = []
    }
}

extension ReviewsPresenter: ReviewsViewOutput {
    
    func configure() {
        view?.prepareInterface()
    }
    
    func didRequestReviews() {
        output.didRequestReviews()
    }
    
    var numberOfSections: Int {
        return sectionModels.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return sectionModels[section].cellModels.count
    }
    
    func identifierForCell(at row: Int, in section: Int) -> String {
        return sectionModels[section].cellModels[row].cellIdentifier
    }
    
    func configure(cell: TableCell, at row: Int, in section: Int) {
        cell.model = sectionModels[section].cellModels[row]
    }
    
    func heightForHeader(in section: Int) -> CGFloat {
        return sectionModels[section].headerHeight
    }
    
    func congigure(header: TableSection, in section: Int) {
        header.model = sectionModels[section]
    }
}
