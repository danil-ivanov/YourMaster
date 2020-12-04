

import Foundation
import UIKit

protocol ShopsRouterInput {
    func showMap()
    func showFloatingPanel()
    func showInfo(shop: Shop)
    func showDescriptionViewer(description: String)
    func showPhotosViewer()
    func showReviewsView()
}

final class ShopsRouter: ShopsRouterInput {
    private let assembly: ShopsAssemblyProtocol
    weak var navigationController: UINavigationController?
    
    init(assembly: ShopsAssemblyProtocol) {
        self.assembly = assembly
        self.navigationController = UINavigationController.upperNavigationController
    }
    
    func showMap() {
        let viewController = assembly.shopsMapViewController()
        navigationController?.setViewControllers([viewController], animated: true)
    }
    
    func showFloatingPanel() {
        let viewController = navigationController?.topViewController
        let mastersListController = assembly.shopsListViewController()
        viewController?.addChild(mastersListController)
        viewController?.view.addSubview(mastersListController.view)
        mastersListController.didMove(toParent: viewController)
    }
    
    func showInfo(shop: Shop) {
        let infoVC = assembly.shopInfoViewController(with: shop)
        navigationController?.pushViewController(infoVC, animated: true)
    }
    
    func showDescriptionViewer(description: String) {
        let viewController = DescriptionViewerViewController(description: description)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showPhotosViewer() {
        
    }
    
    func showReviewsView() {
        
    }
}
