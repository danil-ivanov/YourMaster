

import UIKit

final class MapToolBarView: UIView {
    
    private let backgroundSearchBarView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 36))
        view.backgroundColor = .white
        return view
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Поиск..."
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.backgroundColor = .white
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 36))
        backView.backgroundColor = .white
        return searchBar
    }()
    
    let menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setImage(AppAssets.menu, for: .normal)
        return button
    }()
    
    let filtersButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setImage(AppAssets.filters?.tint(with: .black), for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        clipsToBounds = true
        backgroundColor = .clear
        setupViews()
        
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(menuButton)
        addSubview(searchBar)
        addSubview(filtersButton)
        
        NSLayoutConstraint.activate([
                                    menuButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                                    menuButton.heightAnchor.constraint(equalToConstant: 44),
                                    menuButton.widthAnchor.constraint(equalToConstant: 44),
                                    menuButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                                        
                                    searchBar.centerYAnchor.constraint(equalTo: centerYAnchor),
                                    searchBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
                                    searchBar.leadingAnchor.constraint(equalTo: menuButton.trailingAnchor, constant: 10),
                                    searchBar.heightAnchor.constraint(equalToConstant: 44),
                            
        
                                    filtersButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 10),
                                    filtersButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                                    filtersButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                                    filtersButton.heightAnchor.constraint(equalToConstant: 44),
                                    filtersButton.widthAnchor.constraint(equalToConstant: 44)])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyStyles()
    }
    
    private func applyStyles() {
        searchBar.apply(.roundedStyle())
        searchBar.searchTextField.apply(.roundedStyle())
        menuButton.apply(.roundedStyle())
        filtersButton.apply(.roundedStyle())
        searchBar.setSearchFieldBackgroundImage(backgroundSearchBarView.asImage(), for: .normal)
    }
}
