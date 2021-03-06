

import UIKit

protocol SectionRepresentable {
    var model: SectionIdentifiable? { get set }
}

open class TableSection: UITableViewHeaderFooterView, SectionRepresentable {
    
    class public var cellIdentifier: String {
        return String.className(self)
    }
    
    var model: SectionIdentifiable? {
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
