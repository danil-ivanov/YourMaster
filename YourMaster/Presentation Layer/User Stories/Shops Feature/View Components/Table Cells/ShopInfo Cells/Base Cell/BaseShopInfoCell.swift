

import UIKit

final class BaseShopInfoCell: TableCell {
    
    private enum Dimensions {
        enum ImageView {
            static let leftOffset: CGFloat = 16.0
            static let rightOffset: CGFloat = 20.0
            static let width: CGFloat = 90.0
            static let heihgt: CGFloat = 90.0
            static let topOffset: CGFloat = 0.0
            static let bottomOffset: CGFloat = 25.0
        }
        enum ShopNameLabel {
            static let topOffset: CGFloat = 5.0
            static let rightOffset: CGFloat = 20.0
        }
        enum AddressLabel {
            static let topOffset: CGFloat = 10.0
            static let rightOffset: CGFloat = 20.0
        }
        enum RatingImageView {
            static let leftOffset: CGFloat = 16.0
            static let bottomOffset: CGFloat = 20.0
            static let height: CGFloat = 20.0
            static let width: CGFloat = 100.0
        }
        enum RatingLabel {
            static let leftOffset: CGFloat = 5.0
        }
    }

    override class var cellIdentifier: String {
        return String.className(self)
    }
    
    private let shopImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .purple
        imageView.layer.cornerRadius = 10
        imageView.image = AppAssets.avatarMock
        return imageView
    }()
    
    private let shopNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 3
        label.font = SFUIDisplay.bold.font(size: 18)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.font = SFUIDisplay.light.font(size: 13)
        return label
    }()
    
    private let ratingView: FloatRatingView = {
        let view = FloatRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        let starImage = AppAssets.rating
        view.fullImage = starImage?.tint(with: .systemYellow)
        view.emptyImage = starImage?.tint(with: .systemGray5)
        return view
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .white
        label.font = SFUIDisplay.regular.font(size: 15)
        return label
    }()
    
    override func setupView() {
        addSubview(shopImageView)
        addSubview(shopNameLabel)
        addSubview(addressLabel)
        addSubview(ratingView)
        //addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            shopImageView.topAnchor.constraint(equalTo: topAnchor, constant: Dimensions.ImageView.topOffset),
            shopImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Dimensions.ImageView.leftOffset),
            shopImageView.trailingAnchor.constraint(equalTo: shopNameLabel.leadingAnchor, constant: -Dimensions.ImageView.rightOffset),
            shopImageView.widthAnchor.constraint(equalToConstant: Dimensions.ImageView.width),
            shopImageView.heightAnchor.constraint(equalToConstant: Dimensions.ImageView.heihgt),
            shopImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Dimensions.ImageView.bottomOffset),
            
            shopNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Dimensions.ShopNameLabel.topOffset),
            shopNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Dimensions.ShopNameLabel.rightOffset),
        
            addressLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Dimensions.AddressLabel.rightOffset),
            addressLabel.leadingAnchor.constraint(equalTo: shopNameLabel.leadingAnchor),
            addressLabel.topAnchor.constraint(equalTo: shopNameLabel.bottomAnchor, constant: Dimensions.ShopNameLabel.topOffset)
        ])
    }
    
    override func updateViews() {
        guard let model = self.model as? BaseShopInfoCellModel else {
            return
        }
        shopNameLabel.text = model.shopName
        addressLabel.text = model.address
        ratingLabel.text = "4.0"
        ratingView.rating = 4.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //shopImageView.apply(.roundedStyle())
    }
}
