
final class ReviewsAndDistanceCellModel: TableCellModel {
    override var cellIdentifier: String {
        return ReviewsAndDistanceCell.cellIdentifier
    }
    
    let rating: Float
    let reviewsCount: Int
    let distance: Float
    
    init(rating: Float, distance: Float, reviewsCount: Int) {
        self.rating = rating
        self.distance = distance
        self.reviewsCount = reviewsCount
    }
}
