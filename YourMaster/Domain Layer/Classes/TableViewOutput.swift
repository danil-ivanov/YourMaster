//
//  TableViewOutput.swift
//  YourMaster
//
//  Created by Maxim Egorov on 19.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

protocol TableViewOutput: AnyObject {
    
    var sectionModels: [TableSectionModel] { get set }

    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func identifierForCell(at row: Int, in section: Int) -> String
    func configure(cell: TableCell, at row: Int, in section: Int)
    func heightForHeader(in section: Int) -> CGFloat
    func congigure(header: TableSection, in section: Int)
    func didSelectRow(_ row: Int, in section: Int)
}

extension TableViewOutput {
    var numberOfSections: Int {
        return sectionModels.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return sectionModels[section].cellModels.count
    }
    
    func identifierForCell(at row: Int, in section: Int) -> String {
        return sectionModels[section].cellModels[row].cellIdentifier
    }
    
    func congigure(header: TableSection, in section: Int) {
        header.model = sectionModels[section]
    }
    
    func configure(cell: TableCell, at row: Int, in section: Int) {
        cell.model = sectionModels[section].cellModels[row]
    }
    
    func heightForHeader(in section: Int) -> CGFloat {
        return sectionModels[section].headerHeight
    }
    
    func didSelectRow(_ row: Int, in section: Int) {}
}
