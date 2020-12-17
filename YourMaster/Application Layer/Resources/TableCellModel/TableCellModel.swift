

import UIKit

public protocol CellIdentifiable {
    var cellIdentifier: String { get }
}

public protocol TableCellIdentifiable: CellIdentifiable {
    var cellHeight: CGFloat { get }
}

open class TableCellModel: TableCellIdentifiable {
    
    // MARK: - Props
    public var cellIdentifier: String {
        return ""
    }
    
    public var cellHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - Initialization
    init() { }
    
}
