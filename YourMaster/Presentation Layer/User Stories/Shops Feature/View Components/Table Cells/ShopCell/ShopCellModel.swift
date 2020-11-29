

import Foundation

final class ShopCellModel: TableCellModel {
    override var cellIdentifier: String {
        ShopCell.cellIdentifier
    }
    
    let imagePath: String
    let shopName: String
    let shopAdress: String
    
    init(imagePath: String, shopName: String, shopAdress: String) {
        self.imagePath = imagePath
        self.shopName = shopName
        self.shopAdress = shopAdress
    }
}
