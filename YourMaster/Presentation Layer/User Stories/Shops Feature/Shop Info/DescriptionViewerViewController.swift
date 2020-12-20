

import UIKit

final class DescriptionLabel: UILabel {

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let width = size.width + 20
        let height = size.height + 15
        return CGSize(width: width, height: height)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)))
    }
    
}

final class DescriptionViewerViewController: UIViewController {
    
    private let textLabel: DescriptionLabel = {
        let label = DescriptionLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.font = SFUIDisplay.regular.font(size: 16)
        return label
    }()
    
    private let text: String
    
    init(description: String) {
        self.text = description
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Описание"
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        textLabel.text = text
        view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
}
