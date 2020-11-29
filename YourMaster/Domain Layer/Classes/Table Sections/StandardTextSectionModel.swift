

import UIKit

final class StandardTextSectionModel: TableSectionModel {
    
    override var headerIdentifier: String {
        return StandardTextSection.cellIdentifier
    }
    
    override var headerHeight: CGFloat {
        return height
    }
    
    let title: String
    let height: CGFloat

    init(title: String, height: CGFloat) {
        self.title = title
        self.height = height
    }
}
