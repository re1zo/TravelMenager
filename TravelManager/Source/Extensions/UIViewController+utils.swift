import UIKit

extension UIViewController {
    
    func performSegue(withIdentifier: String) {
        performSegue(withIdentifier: withIdentifier, sender: nil)
    }
}
