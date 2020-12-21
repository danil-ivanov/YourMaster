

import UIKit

final class PhotoCollectionCell: CollectionCell {
    
    override class var cellIdentifier: String {
        return String.className(self)
    }
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .purple
        imageView.image = AppAssets.avatarMock
        return imageView
    }()
    
    override func setupView() {
        self.model = PhotoCollectionCellModel()
        addSubview(photoImageView)
        NSLayoutConstraint.activate([
                                        photoImageView.topAnchor.constraint(equalTo: topAnchor),
                                        photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                        photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                        photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
