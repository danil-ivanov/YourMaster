

import UIKit

protocol TableSectionRepresentable {
    var model: TableSectionIdentifiable? { get set }
}

open class TableSection: UITableViewHeaderFooterView, TableSectionRepresentable {
    
    class public var cellIdentifier: String {
        return String.className(self)
    }
    
    var model: TableSectionIdentifiable? {
        didSet {
            updateViews()
        }
    }
    
    var rows: [TableCellIdentifiable] = []
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    open func setupView() { }
    
    open func updateViews() { }
    
}
