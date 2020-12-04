
import UIKit


final class StandardTextSection: TableSection {
    override class var cellIdentifier: String {
        return String.className(self)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = SFUIDisplay.bold.font(size: 20)
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attrTitle = NSAttributedString(string: "Все", attributes: [.font: SFUIDisplay.regular.font(size: 17),
                                                                          .foregroundColor: UIColor.systemBlue])
        button.setAttributedTitle(attrTitle, for: .normal)
        return button
    }()
    
    override func setupView() {
        addSubview(titleLabel)
        addSubview(moreButton)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            moreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            moreButton.heightAnchor.constraint(equalTo: heightAnchor, constant: -20)])

        setupAction()
    }
    
    override func updateViews() {
        guard let model = self.model as? StandardTextSectionModel else {
            return
        }
        titleLabel.text = model.title
        moreButton.isHidden = !model.moreButtonNeeded
    }
    
    private func setupAction() {
        moreButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
    }
    
    @objc
    func buttonDidTap() {
        guard let model = self.model as? StandardTextSectionModel else {
            return
        }
        model.action?()
    }
}
