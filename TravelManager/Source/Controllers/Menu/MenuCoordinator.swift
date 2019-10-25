import UIKit
import RxSwift

final class MenuCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let storyboard = UIStoryboard(name: "Menu", bundle: .main)
        let signUpViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        navigationController.pushViewController(signUpViewController, animated: true)
    }
}
