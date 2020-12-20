

import UIKit

public extension UICollectionView {
    
    func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        
        self.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func registerReusableViewClass(_ reusableViewClass: AnyClass, kind: String) {
        let identifier = String.className(reusableViewClass)
        register(reusableViewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }
}
