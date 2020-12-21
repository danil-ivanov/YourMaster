

import UIKit

class ShopCell: TableCell {
    @IBOutlet private weak var shopImageView: UIImageView!
    @IBOutlet private weak var shopNameLabel: UILabel!
    @IBOutlet private weak var adressLabel: UILabel!
    
    override class var cellIdentifier: String {
        return String.className(self)
    }
    
    override func setupView() {
        shopImageView.layer.cornerRadius = 10
        shopImageView.image = AppAssets.avatarMock
        shopNameLabel.font = SFUIDisplay.bold.font(size: 17)
        adressLabel.font = SFUIDisplay.regular.font(size: 14)
    }
    
    override func updateViews() {
        guard let model = self.model as? ShopCellModel else { return }
        shopImageView.backgroundColor = .blue
        shopNameLabel.text = model.shopName
        adressLabel.text = model.shopAdress
    }
}
