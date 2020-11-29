

import Foundation
import UIKit

protocol ShopsListViewOutput: class {
    var numberOfShops: Int { get }
    func configure()
    func configure(cell: ShopCell, at row: Int)
    func search(_ text: String)
    func myLocationButtonDidTap()
    func didSelectCell(at row: Int)
}

final class ShopsListViewController: UIViewController {
    struct Dimensions {
        static let tableHeaderHeight: CGFloat = 20.0
        struct Stork {
            static let middleHeight: CGFloat = 200.0
        }
        struct Loader {
            static let topOffset: CGFloat = 90.0
        }
        struct Toolbar {
            static let height: CGFloat = 50.0
        }
        struct MyLocationButton {
            static let rightOffset: CGFloat = 20.0
            static let bottomOffset: CGFloat = 20.0
            static let width: CGFloat = 50.0
            static let height: CGFloat = 50.0
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.tableFooterView = UIView()
        return table
    }()
    
    private lazy var listView: BottomListView & ShopsScrollViewDelegate = {
        let view = BottomListView(content: tableView)
        view.output = self
        return view
    }()
    
    private let toolbarView: MapToolBarView = {
        let view = MapToolBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let myLocationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setImage(AppAssets.myLocation, for: .normal)
        return button
    }()
    
    private lazy var tableHeaderView: StorkHeaderView = {
        let view = StorkHeaderView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: tableView.bounds.width,
                                                 height: Dimensions.tableHeaderHeight))
        return view
    }()
    
    private var isSearching: Bool = false
    
    private var myLocationButtonTopOffset: CGFloat?
    private lazy var myLocationButtonTopConstraint: NSLayoutConstraint =  {
        myLocationButton.topAnchor.constraint(equalTo: view.topAnchor,
                                                 constant: myLocationButtonTopOffset ?? 0)
    }()
    
    var output: ShopsListViewOutput?
    weak var scrollViewDelegate: ShopsScrollViewDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let rect = (parent?.view.bounds.insetBy(dx: 0, dy: UIScreen.statusBarHeight)) ?? .zero
        self.view = TouchesPassView(frame: rect)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myLocationButton.apply(.roundedStyle())
    }

    private func setupViews() {
        tableView.tableHeaderView = tableHeaderView
        view.addSubview(myLocationButton)
        view.addSubview(listView)
        view.addSubview(toolbarView)
        NSLayoutConstraint.activate([toolbarView.topAnchor.constraint(equalTo: view.topAnchor),
                                     toolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     toolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     toolbarView.heightAnchor.constraint(equalToConstant: Dimensions.Toolbar.height),
        
                                     myLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Dimensions.MyLocationButton.rightOffset),
                                     myLocationButton.widthAnchor.constraint(equalToConstant: Dimensions.MyLocationButton.width),
                                     myLocationButton.heightAnchor.constraint(equalToConstant: Dimensions.MyLocationButton.height)])
        
        myLocationButtonTopOffset = listView.frame.origin.y - 20 - Dimensions.MyLocationButton.height
        myLocationButtonTopConstraint.isActive = true
    }
    
    private func setupActions() {
        myLocationButton.addTarget(self, action: #selector(myLocationButtonDidTap), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(ShopCell.self)
    }
    
    @objc
    func myLocationButtonDidTap() {
        ImpactFeedbackGenerator.impactOccured()
        output?.myLocationButtonDidTap()
    }
}

extension ShopsListViewController: ShopsListViewInput {
    func presentShops() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func prepareInterface() {
        view.backgroundColor = .clear
        setupViews()
        setupTableView()
        toolbarView.searchBar.delegate = self
    }
    
    func startLoading() {
        listView.startLoader(topOffset: Dimensions.Loader.topOffset)
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.listView.stopLoader()
        }
    }
    
    func set(state: BottomListView.PositionState) {
        if isSearching { return }
        listView.set(position: state)
    }
}

extension ShopsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.numberOfShops ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShopCell.cellIdentifier) as? ShopCell else {
            return UITableViewCell()
        }
        output?.configure(cell: cell, at: indexPath.row)
        return cell
    }
}

extension ShopsListViewController: UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        listView.scrollViewWillBeginDragging(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listView.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        listView.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        listView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelectCell(at: indexPath.row)
    }
}

extension ShopsListViewController: BottomListViewOutput {
    func didUpdateHeight(newHeight: CGFloat) {
        if isSearching {
            view.endEditing(true)
        }
        if listView.frame.origin.y <= Dimensions.Toolbar.height {
            if toolbarView.backgroundColor == UIColor.white {
                return
            }
            toolbarView.backgroundColor = .white
            parent?.setStatusBarColor(.white)
            tableHeaderView.isHidden = true
        } else {
            if newHeight <= Dimensions.Stork.middleHeight {
                guard let myLocationButtonTopOffset = myLocationButtonTopOffset else {
                    return
                }
                myLocationButtonTopConstraint.constant = myLocationButtonTopOffset + (Dimensions.Stork.middleHeight - newHeight)
                myLocationButton.layoutIfNeeded()
            }
            if toolbarView.backgroundColor == UIColor.clear {
                return
            }
            toolbarView.backgroundColor = .clear
            parent?.setStatusBarColor(.clear)
            tableHeaderView.isHidden = false
        }
    }
}

extension ShopsListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        ImpactFeedbackGenerator.impactOccured()
        isSearching = true
        listView.set(position: .fullScreen)
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else {
            return
        }
        output?.search(text)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        isSearching = false
        return true
    }
}
