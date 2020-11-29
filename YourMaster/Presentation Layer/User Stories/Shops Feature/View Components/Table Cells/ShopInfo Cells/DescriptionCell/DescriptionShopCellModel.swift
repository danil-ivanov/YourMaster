

final class DescriptionShopInfoCellModel: TableCellModel {
    
    override var cellIdentifier: String {
        return DescriptionShopInfoCell.cellIdentifier
    }
    
    let description: String
    
    init(description: String) {
        self.description = description
    }
}
