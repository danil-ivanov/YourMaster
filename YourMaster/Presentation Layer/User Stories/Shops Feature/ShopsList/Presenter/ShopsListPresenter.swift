

import UIKit

protocol ShopsListPresenterOutput: AnyObject {
    func didRequestPresentMyLocation()
    func didSearch(text: String)
    func searchDidEnd()
    func didSelect(shop: Shop)
}

final class ShopsListPresenter {
    private let output: ShopsListPresenterOutput
    weak var view: ShopsListViewInput?
    private var shopsCellModels: [ShopCellModel]
    private var shops: [Shop]
    
    private var filteredShops: [Shop] {
        didSet {
            self.shopsCellModels = filteredShops.map{ ShopCellModel(imagePath: "", shopName: $0.name, shopAdress: $0.location.address) }
            view?.presentShops()
        }
    }
    
    init(output: ShopsListPresenterOutput) {
        self.output = output
        self.shops = []
        self.shopsCellModels = []
        self.filteredShops = []
    }
}

extension ShopsListPresenter: ShopsListPresenterInput {
    func stopLoadingifNeeded() {
        view?.finishLoading()
    }
    
    func presentShops(shops: [Shop]) {
        view?.finishLoading()
        self.shops = shops
        self.filteredShops = shops
    }
    
    func setStorkState(state: BottomListView.PositionState) {
        view?.set(state: state)
    }
}

extension ShopsListPresenter: ShopsListViewOutput {
    var numberOfShops: Int {
        return shopsCellModels.count
    }
    
    func configure() {
        view?.prepareInterface()
        view?.startLoading()
    }
    
    func configure(cell: ShopCell, at row: Int) {
        let model = shopsCellModels[row]
        cell.model = model
    }
    
    func search(_ text: String) {
        if text.isEmpty {
            output.searchDidEnd()
            filteredShops = shops
            return
        }
        output.didSearch(text: text)
        filteredShops = shops.filter{ $0.name.lowercased().hasPrefix(text.lowercased()) }
    }
    
    func myLocationButtonDidTap() {
        output.didRequestPresentMyLocation()
    }
    
    func didSelectCell(at row: Int) {
        let shop = shops[row]
        output.didSelect(shop: shop)
    }
}
