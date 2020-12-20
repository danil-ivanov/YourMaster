

import UIKit

protocol ShopInfoPresenterOutput: AnyObject {
    func showDescriptionViewer(description: String)
    func showPhotosViewer()
    func showReviewsView()
    func showServices(of shop: Shop)
}

final class ShopInfoPresenter {
    private let output: ShopInfoPresenterOutput
    weak var view: ShopInfoViewInput?
    
    private let shop: Shop

    private var sectionModels: [TableSectionModel] {
        didSet {
            view?.presentInfo()
        }
    }
    
    init(shop: Shop, output: ShopInfoPresenterOutput) {
        self.output = output
        self.shop = shop
        self.sectionModels = []
		let nc = NotificationCenter.default
		nc.addObserver(self, selector: #selector(addToFavAction), name: Notification.Name("AddToFav"), object: nil)
        prepareModels()
    }
	
	@objc func addToFavAction() {
		if let data = UserDefaults.standard.value(forKey:"favShops") as? Data {
			var shops = try? PropertyListDecoder().decode(Array<Shop>.self, from: data)
			shops?.append(shop)
			UserDefaults.standard.set(try? PropertyListEncoder().encode(shops), forKey:"favShops")
		} else {
			let shops = [shop]
			UserDefaults.standard.set(try? PropertyListEncoder().encode(shops), forKey:"favShops")
		}
	}
    
    private func prepareModels() {
        let baseModel = StandardTextSectionModel(title: "", height: 0.0)
        baseModel.cellModels.append(BaseShopInfoCellModel(imagePath: "", shopName: shop.name, address: shop.location.address))
        let servicesCellModel = ServicesCellModel()
        servicesCellModel.action = { [weak self] in
            guard let self = self else {
                return
            }
            self.output.showServices(of: self.shop)
        }
        baseModel.cellModels.append(servicesCellModel)
        
        let descriptionModel = StandardTextSectionModel(title: "Описание", height: 50.0)
        let descriptionCellModel = DescriptionShopInfoCellModel(description: "On third line our text need be collapsed because we have ordinary text, sed diam nonumy eirmod tempor invidunt ")
        descriptionModel.cellModels.append(descriptionCellModel)
        
        let contactsModel = StandardTextSectionModel(title: "Контакты", height: 50.0)
        contactsModel.cellModels.append(ContactCellModel(contact: "+79697298209"))
        contactsModel.cellModels.append(ContactCellModel(contact: "www.instagram.com/sequoiaspb/"))
        
        let photoModel = StandardTextSectionModel(title: "Фото", height: 50.0, moreButtonNeeded: true)
        photoModel.cellModels.append(PhotoShopInfoCellModel())
        photoModel.action = { [weak self] in
            self?.output.showPhotosViewer()
        }
        
        let reviewsModel = StandardTextSectionModel(title: "Отзывы", height: 50.0, moreButtonNeeded: true)
        reviewsModel.cellModels.append(ReviewsCellModel(reviews: []))
        reviewsModel.action = { [weak self] in
            self?.output.showReviewsView()
        }
        
        sectionModels = [baseModel, descriptionModel, contactsModel, photoModel, reviewsModel]
    }
}

extension ShopInfoPresenter: ShopInfoViewOutput {
    var numberOfSections: Int {
        return sectionModels.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return sectionModels[section].cellModels.count
    }
    
    func identifierForCell(at row: Int, in section: Int) -> String {
        return sectionModels[section].cellModels[row].cellIdentifier
    }
    
    func configure() {
        view?.prepareInterface()
    }
    
    func configure(cell: TableCell, at row: Int, in section: Int) {
        cell.model = sectionModels[section].cellModels[row]
    }
    
    func heightForHeader(in section: Int) -> CGFloat {
        return sectionModels[section].headerHeight
    }
    
    func congigure(header: TableSection, in section: Int) {
        header.model = sectionModels[section]
    }
    
    func didSelectRow(_ row: Int, in section: Int) {
        let model = sectionModels[section]
        let cellModel = model.cellModels[row]
        if cellModel is DescriptionShopInfoCellModel {
            output.showDescriptionViewer(description: (cellModel as? DescriptionShopInfoCellModel)?.description ?? "")
        }
    }
}
