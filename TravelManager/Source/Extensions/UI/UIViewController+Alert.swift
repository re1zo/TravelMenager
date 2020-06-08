import UIKit

extension UIViewController {

    func infoAlert(title: String = "Error", message: String) {
        // TODO: Basic implementation, will be rewritten to rx solution.
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
