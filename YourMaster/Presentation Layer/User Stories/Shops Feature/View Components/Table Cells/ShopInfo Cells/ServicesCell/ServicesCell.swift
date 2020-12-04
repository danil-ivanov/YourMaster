
import UIKit

final class ServicesCell: TableCell {
    
    override class var cellIdentifier: String {
        return String.className(self)
    }
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.layer.cornerRadius = 6
        button.setTitle("Услуги и цены", for: .normal)
        button.titleLabel?.font = SFUIDisplay.medium.font(size: 17)
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = .zero
        return button
    }()
    
    override func setupView() {
        contentView.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 45)])
        
        setupAction()
    }
    
    func setupAction() {
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc
    func didTapButton() {
        guard let model = self.model as? ServicesCellModel else {
            return
        }
        model.action?()
    }
}
