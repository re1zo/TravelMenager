import UIKit

final class MainViewController: UIViewController {
    let dupa = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        performSegue(withIdentifier: "showSignIn")
    }
}
