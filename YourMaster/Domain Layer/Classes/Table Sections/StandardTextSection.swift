
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
    
    override func setupView() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)])
    }
    
    override func updateViews() {
        guard let model = self.model as? StandardTextSectionModel else {
            return
        }
        titleLabel.text = model.title
    }
}
