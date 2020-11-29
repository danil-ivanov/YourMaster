

final class ReviewCollectionCellModel: CollectionCellModel {
    override var cellIdentifier: String {
        return ReviewCollectionCell.cellIdentifier
    }
    
    let review: String
    
    init(review: String) {
        self.review = review
    }
}
