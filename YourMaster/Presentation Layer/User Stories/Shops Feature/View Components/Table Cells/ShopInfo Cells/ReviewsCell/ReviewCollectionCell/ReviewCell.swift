

import UIKit

final class ReviewCell: TableCell {
    
    override class var cellIdentifier: String {
        return String.className(self)
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Вчера"
        label.textColor = .systemGray2
        return label
    }()
    
    private let userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Максим Егоров"
        label.font = SFUIDisplay.medium.font(size: 16)
        return label
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Все понравилось"
        label.font = SFUIDisplay.regular.font(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let moreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = SFUIDisplay.regular.font(size: 16)
        label.textColor = .systemBlue
        label.text = "Показать больше"
        return label
    }()
    
    private let ratingView: FloatRatingView = {
        let view = FloatRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.fullImage = AppAssets.rating?.tint(with: .systemYellow)
        view.emptyImage = AppAssets.rating?.tint(with: .systemGray5)
        view.rating = 4.5
        view.backgroundColor = .systemGray6
        return view
    }()
    
    override func setupView() {
        layer.cornerRadius = 1
        addSubview(dateLabel)
        addSubview(userLabel)
        addSubview(ratingView)
        addSubview(reviewLabel)
        addSubview(moreLabel)
        
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            userLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -10),
                                        
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateLabel.topAnchor.constraint(equalTo: userLabel.topAnchor),
        
            ratingView.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 10),
            ratingView.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            ratingView.widthAnchor.constraint(equalToConstant: 100),
            ratingView.heightAnchor.constraint(equalToConstant: 20),
        
            reviewLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 16),
            reviewLabel.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            reviewLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            reviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16),
    
                                        moreLabel.topAnchor.constraint(equalTo: reviewLabel.bottomAnchor),
                                        moreLabel.leadingAnchor.constraint(equalTo: reviewLabel.leadingAnchor)])
    }
    
    override func updateViews() {
        guard let model = self.model as? ReviewCellModel else {
            return
        }
        reviewLabel.text = model.review
        reviewLabel.layoutIfNeeded()
        if reviewLabel.isTruncated {
            moreLabel.isHidden = false
            return
        }
        moreLabel.isHidden = true
    }
}
