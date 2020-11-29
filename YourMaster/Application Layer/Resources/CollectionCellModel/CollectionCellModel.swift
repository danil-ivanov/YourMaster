
import UIKit

public protocol CollectionCellIdentifiable: TableCellIdentifiable {
    var cellWidth: CGFloat { get }
}

open class CollectionCellModel: CollectionCellIdentifiable {
    
    // MARK: - Props
    public var cellIdentifier: String {
        return ""
    }
    
    public var cellHeight: CGFloat {
        return 0
    }
    
    public var cellWidth: CGFloat {
        return 0
    }
    
    public var userInfo: [String: Any] = [:]
    
    // MARK: - Initialization
    public init() { }
    
}
