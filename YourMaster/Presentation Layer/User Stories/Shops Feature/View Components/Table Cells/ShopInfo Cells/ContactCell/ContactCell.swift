

import UIKit

final class ContactCell: TableCell {
    
    override class var cellIdentifier: String {
        return String.className(self)
    }
    
    private let contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = SFUIDisplay.regular.font(size: 17)
        return label
    }()
    
    override func setupView() {
        addSubview(contactImageView)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),

            contactImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contactImageView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            contactImageView.heightAnchor.constraint(equalToConstant: 40),
            contactImageView.widthAnchor.constraint(equalToConstant: 40)])
    }
    
    override func updateViews() {
        guard let model = self.model as? ContactCellModel else {
            return
        }
        switch model.contactType {
        case .phoneNumber(let number):
            label.text = number
            contactImageView.image = AppAssets.whatsApp
        case .instagram(let link):
            label.text = link
            contactImageView.image = AppAssets.instagram
        case .webSite(let _):
            break
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contactImageView.apply(.roundedStyle())
    }
}
