

import UIKit

fileprivate final class InfoView: UIView {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = SFUIDisplay.semibold.font(size: 17)
        label.textColor = .black
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = SFUIDisplay.regular.font(size: 13)
        label.textColor = .gray
        return label
    }()
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
                                        imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                        imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                        imageView.heightAnchor.constraint(equalToConstant: 36),
                                        imageView.widthAnchor.constraint(equalToConstant: 36),
        
                                        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
                                        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                                        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
                                        titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -8),
        
                                        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                                        subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                                        subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)])
    }
}

final class ReviewsAndDistanceCell: TableCell {
    
    override class var cellIdentifier: String {
        return String.className(self)
    }
    
    private let reviewsView: InfoView = {
        let view = InfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let distanceView: InfoView = {
        let view = InfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override func setupView() {
        contentView.addSubview(reviewsView)
        contentView.addSubview(distanceView)
        setupGestureRecognizer()
        NSLayoutConstraint.activate([
            reviewsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            reviewsView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            distanceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -45),
            distanceView.centerYAnchor.constraint(equalTo: centerYAnchor),
            distanceView.leadingAnchor.constraint(equalTo: reviewsView.trailingAnchor, constant: 54),
            distanceView.widthAnchor.constraint(equalTo: reviewsView.widthAnchor)
        ])
    }
    
    override func updateViews() {
        guard let model = self.model as? ReviewsAndDistanceCellModel else {
            return
        }
        reviewsView.image = AppAssets.reviewsEllipse
        reviewsView.title = String(model.rating)
        reviewsView.subtitle = String(model.reviewsCount) + " " + reviewsString(from: model.reviewsCount)
        distanceView.image = AppAssets.distanceEllipse
        distanceView.title = String(format: "%.1f", model.distance) + " км"
        distanceView.subtitle = "расстояние"
    }
    
    private func reviewsString(from count: Int) -> String {
        let lastDigit = count % 10
        if lastDigit == 1 && count == 1 {
            return "отзыв"
        }
        if lastDigit < 5 {
            return "отзыва"
        }
        return "отзывов"
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureDidTap))
        reviewsView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func gestureDidTap() {
        (model as? ReviewsAndDistanceCellModel)?.reviewsTap?()
    }
}
