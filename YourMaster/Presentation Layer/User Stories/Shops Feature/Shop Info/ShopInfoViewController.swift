
import UIKit

protocol ShopInfoViewOutput: AnyObject {
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func identifierForCell(at row: Int, in section: Int) -> String
    func configure()
    func configure(cell: TableCell, at row: Int, in section: Int)
    func heightForHeader(in section: Int) -> CGFloat
    func congigure(header: TableSection, in section: Int)
    func didSelectRow(_ row: Int, in section: Int)
}

final class ShopInfoViewController: UIViewController {
    
    private let output: ShopInfoViewOutput
	let addToFav = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionFooterHeight = CGFloat.leastNormalMagnitude
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    init(output: ShopInfoViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    private func setupViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func registerTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCellClass(BaseShopInfoCell.self)
        tableView.registerCellClass(PhotoShopInfoCell.self)
        tableView.registerCellClass(DescriptionShopInfoCell.self)
        tableView.registerHeaderFooterViewClass(StandardTextSection.self)
        tableView.registerCellClass(ContactCell.self)
        tableView.registerCellClass(ServicesCell.self)
        tableView.registerCellClass(ReviewsCell.self)
    }
    
    private func setupNavigationBar() {
        title = "Информация"
        navigationController?.navigationBar.titleTextAttributes = [.font : SFUIDisplay.semibold.font(size: 15)]
        navigationController?.navigationBar.shouldRemoveShadow(true)
        let backItem = UIBarButtonItem()
        navigationItem.backBarButtonItem = backItem
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.delegate = self
		addToFav.setImage(UIImage(named: "notSelectedFav"), for: .normal)
		addToFav.addTarget(self, action: #selector(addToFavAction), for: .touchUpInside)
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addToFav)
    }
	
	@objc func addToFavAction() {
		let nc = NotificationCenter.default
		nc.post(name: Notification.Name("AddToFav"), object: nil)
		addToFav.setImage(UIImage(named: "selectedFav"), for: .normal)
	}
}

extension ShopInfoViewController: ShopInfoViewInput {
    func prepareInterface() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupNavigationBar()
        setupViews()
        registerTableView()
    }

    func presentInfo() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ShopInfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = output.identifierForCell(at: indexPath.row, in: indexPath.section)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TableCell else {
            return UITableViewCell()
        }
        output.configure(cell: cell, at: indexPath.row, in: indexPath.section)
        return cell
    }
}

extension ShopInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return output.heightForHeader(in: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: StandardTextSection.cellIdentifier) as? TableSection else {
            return UIView()
        }
        output.congigure(header: header, in: section)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRow(indexPath.row, in: indexPath.section)
    }
}

extension ShopInfoViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is ShopsMapViewController {
            navigationController.setNavigationBarHidden(true, animated: true)
        }
    }
}
