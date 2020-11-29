
final class ReviewsCellModel: TableCellModel {
    override var cellIdentifier: String {
        return ReviewsCell.cellIdentifier
    }
    
    let reviews: [ReviewCollectionCellModel]
    
    init(reviews: [ReviewCollectionCellModel]) {
        self.reviews = reviews
    }
}
