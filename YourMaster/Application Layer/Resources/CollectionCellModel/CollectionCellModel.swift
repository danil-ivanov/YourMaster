
import UIKit

public protocol CollectionCellIdentifiable: CellIdentifiable {
    var cellSize: CGSize { get }
}

open class CollectionCellModel: CollectionCellIdentifiable {
    
    // MARK: - Props
    public var cellIdentifier: String {
        return ""
    }
    
    public var cellSize: CGSize {
        return .zero
    }
    
    public var userInfo: [String: Any] = [:]
    
    // MARK: - Initialization
    public init() { }
    
}
