

import UIKit

protocol ShopInfoPresenterOutput: AnyObject {
    func showDescriptionViewer(description: String)
}

final class ShopInfoPresenter {
    var output: ShopInfoPresenterOutput?
    weak var view: ShopInfoViewInput?
    
    private let shop: Shop

    private var sectionModels: [TableSectionModel] {
        didSet {
            view?.presentInfo()
        }
    }
    
    init(shop: Shop) {
        self.shop = shop
        self.sectionModels = []
        prepareModels()
    }
    
    private func prepareModels() {
        let baseModel = StandardTextSectionModel(title: "", height: 0.0)
        baseModel.cellModels.append(BaseShopInfoCellModel(imagePath: "", shopName: shop.name, address: shop.location.address))
        baseModel.cellModels.append(ServicesCellModel())
        
        let descriptionModel = StandardTextSectionModel(title: "Описание", height: 50.0)
        let descriptionCellModel = DescriptionShopInfoCellModel(description: "On third line our text need be collapsed because we have ordinary text, sed diam nonumy eirmod tempor invidunt ")
        descriptionModel.cellModels.append(descriptionCellModel)
        
        let contactsModel = StandardTextSectionModel(title: "Контакты", height: 50.0)
        contactsModel.cellModels.append(ContactCellModel(contact: "+79697298209"))
        contactsModel.cellModels.append(ContactCellModel(contact: "www.instagram.com/sequoiaspb/"))
        
        let photoModel = StandardTextSectionModel(title: "Фото", height: 50.0)
        photoModel.cellModels.append(PhotoShopInfoCellModel())
        
        let reviewsModel = StandardTextSectionModel(title: "Отзывы", height: 50.0)
        reviewsModel.cellModels.append(ReviewsCellModel(reviews: []))
        
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
            output?.showDescriptionViewer(description: (cellModel as? DescriptionShopInfoCellModel)?.description ?? "")
        }
    }
}
