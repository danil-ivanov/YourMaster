

final class ReviewCellModel: TableCellModel {
    override var cellIdentifier: String {
        return ReviewCell.cellIdentifier
    }
    
    let review: Review
    
    init(review: Review) {
        self.review = review
    }
}
