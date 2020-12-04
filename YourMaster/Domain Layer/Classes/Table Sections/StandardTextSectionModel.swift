

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
    let moreButtonNeeded: Bool
    
    var action: (() -> ())?

    init(title: String, height: CGFloat, moreButtonNeeded: Bool = false) {
        self.title = title
        self.height = height
        self.moreButtonNeeded = moreButtonNeeded
    }
}
