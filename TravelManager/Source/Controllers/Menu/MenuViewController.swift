import UIKit

final class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = AppUser().current else {
            navigationController?.popToRootViewController(animated: true)
            return
        }
    }
}
