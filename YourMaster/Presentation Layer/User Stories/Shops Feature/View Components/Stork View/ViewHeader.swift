

import Foundation
import UIKit

class ViewHeader: UIView {
    private enum Dimensions {
        enum Title {
            static let topOffset: CGFloat = 20.0
            static let leftOffset: CGFloat = 20.0
            static let rightOffset: CGFloat = 20.0
            static let bottomOffset: CGFloat = 10.0
            static let height: CGFloat = 20.0
        }
        enum HeaderControl {
            static let cornerRadius: CGFloat = 3.0
            static let topOffset: CGFloat = 6.0
            static let height: CGFloat = 4.0
            static let width: CGFloat = 50.0
        }
        enum Separator {
            static let bottomOffset: CGFloat = 1.0
            static let height: CGFloat = 1.0
        }
        enum SearchBar {
            static let topOffset: CGFloat = 10.0
            static let leftOffset: CGFloat = 10.0
            static let rightOffset: CGFloat = 40.0
            static let bottomOffset: CGFloat = 10.0
            static let height: CGFloat = 40.0
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = SFUIDisplay.medium.font(size: 15)
        return label
    }()
    
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.searchBarStyle = .minimal
        bar.placeholder = "Поиск"
        bar.clipsToBounds = true
        bar.sizeToFit()
        return bar
    }()
    
    private let headerControl: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = Dimensions.HeaderControl.cornerRadius
        return view
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(headerControl)
        addSubview(separator)
        
        setTitleLabelConstraints()
        setHeaderControlConstraints()
        setSeparatorConstraints()
    }
    
    private func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Dimensions.Title.topOffset),
                                     titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Dimensions.Title.leftOffset),
                                     titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Dimensions.Title.rightOffset),
                                     titleLabel.heightAnchor.constraint(equalToConstant: Dimensions.Title.height),
                                     titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Dimensions.Title.topOffset)])
    }
    
    private func setHeaderControlConstraints() {
        NSLayoutConstraint.activate([headerControl.topAnchor.constraint(equalTo: topAnchor, constant: Dimensions.HeaderControl.topOffset),
                                     headerControl.heightAnchor.constraint(equalToConstant: Dimensions.HeaderControl.height),
                                     headerControl.widthAnchor.constraint(equalToConstant: Dimensions.HeaderControl.width),
                                     headerControl.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    private func setSeparatorConstraints() {
        NSLayoutConstraint.activate([separator.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     separator.widthAnchor.constraint(equalTo: widthAnchor, constant: Dimensions.Separator.bottomOffset),
                                     separator.heightAnchor.constraint(equalToConstant: Dimensions.Separator.height)])
    }
}

extension ViewHeader: ViewHeaderInput {
    func set(title: String) {
        titleLabel.text = title
    }
    
    func showContent() {
        titleLabel.isHidden = false
        separator.isHidden = false
    }
    
    func hideContent() {
        titleLabel.isHidden = true
        separator.isHidden = true
    }
}
