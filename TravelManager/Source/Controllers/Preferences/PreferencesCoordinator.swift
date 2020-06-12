import UIKit
import RxSwift

final class PreferencesCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    private let bag = DisposeBag()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let preferencesViewController = UIStoryboard(name: "Preferences").instantiate(viewController: PreferencesViewController.self)
        preferencesViewController.rx.didMoveToParentViewController
            .subscribe(onNext: { controller in
                if controller == nil {
                    self.end()
                }
            })
            .disposed(by: bag)
        navigationController.pushViewController(preferencesViewController, animated: true)
    }
}
