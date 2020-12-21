//
//  TableViewOutput.swift
//  YourMaster
//
//  Created by Maxim Egorov on 19.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

protocol TableViewOutput: AnyObject {
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func identifierForCell(at row: Int, in section: Int) -> String
    func configure(cell: TableCell, at row: Int, in section: Int)
    func heightForHeader(in section: Int) -> CGFloat
    func congigure(header: TableSection, in section: Int)
    func didSelectRow(_ row: Int, in section: Int)
}

extension TableViewOutput {
    
    func heightForHeader(in section: Int) -> CGFloat {
        return 0
    }
    
    func didSelectRow(_ row: Int, in section: Int) {}
}
