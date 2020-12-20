

final class ReviewCellModel: TableCellModel {
    override var cellIdentifier: String {
        return ReviewCell.cellIdentifier
    }
    
    let review: String
    
    init(review: String) {
        self.review = review
    }
}
