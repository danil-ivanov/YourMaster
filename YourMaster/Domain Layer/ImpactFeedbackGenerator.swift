

import UIKit

struct ImpactFeedbackGenerator {
    private static let generator = UIImpactFeedbackGenerator(style: .medium)
    
    static func impactOccured() {
        generator.impactOccurred()
    }
}
