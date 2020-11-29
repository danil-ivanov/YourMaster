
import UIKit

protocol TableSectionIdentifiable {
    var headerIdentifier: String { get }
    var headerHeight: CGFloat { get }
    var cellModels: [TableCellIdentifiable] { get set }
}

open class TableSectionModel: TableSectionIdentifiable {
    var footerHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    var cellModels: [TableCellIdentifiable]
    
    var headerIdentifier: String {
        return ""
    }
    
    var headerHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    init() {
        self.cellModels = []
    }
    
    
}
