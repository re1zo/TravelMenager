import UIKit
import RxSwift

final class MenuCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    private let bag = DisposeBag()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let menuViewController = UITabBarController()
        menuViewController.rx.didMoveToParentViewController.subscribe(onNext: { controller in
            if controller == nil {
                self.end()
            }
        }).disposed(by: bag)

        let mapCoordinator = MapCoordinator(navigationController: navigationController)
        childCoordinators.append(mapCoordinator)
        mapCoordinator.parentCoordinator = self

        let settingsCoordinator = SettingsCoordinator(navigationController: navigationController)
        childCoordinators.append(settingsCoordinator)
        settingsCoordinator.parentCoordinator = self

        menuViewController.viewControllers = [mapCoordinator.mapViewController, settingsCoordinator.settingsViewController]

        navigationController.pushViewController(menuViewController, animated: true)
    }
}
