

import UIKit

extension UIViewController {
    func showErrorAlert(message: String) {
        DispatchQueue.main.async {
            ImpactFeedbackGenerator.impactOccured()
            let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
}
