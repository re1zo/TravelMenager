import UIKit

final class MenuViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let _ = AppUser().current else {
            navigationController?.popToRootViewController(animated: true)
            return
        }
    }
}
