

final class BaseShopInfoCellModel: TableCellModel {
    override var cellIdentifier: String {
        return BaseShopInfoCell.cellIdentifier
    }
    
    let imagePath: String
    let shopName: String
    let address: String
    
    init(imagePath: String, shopName: String, address: String) {
        self.imagePath = imagePath
        self.shopName = shopName
        self.address = address
    }
}
