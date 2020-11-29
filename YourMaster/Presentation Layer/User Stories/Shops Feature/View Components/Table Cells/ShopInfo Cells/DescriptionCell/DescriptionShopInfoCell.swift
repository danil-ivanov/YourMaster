
import UIKit

final class DescriptionShopInfoCell: TableCell {
    
    override class var cellIdentifier: String {
        return String.className(self)
    }
    
    private let descriptionLabel: UILabel = {
        let label = VerticalTopAlignLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 3
        label.font = SFUIDisplay.regular.font(size: 16)
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: AppAssets.chevronRight?.tint(with: .lightGray))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func setupView() {
        addSubview(descriptionLabel)
        addSubview(chevronImageView)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        
            chevronImageView.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            chevronImageView.heightAnchor.constraint(equalToConstant: 30),
            chevronImageView.widthAnchor.constraint(equalToConstant: 30)])
    }
    
    override func updateViews() {
        guard let model = self.model as? DescriptionShopInfoCellModel else {
            return
        }
        descriptionLabel.text = model.description
    }
}
