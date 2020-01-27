import UIKit
import RxSwift

final class SettingsCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    private let bag = DisposeBag()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    var settingsViewController: UIViewController {
        let settingsViewController = UIStoryboard(name: "Settings").instantiate(viewController: SettingsViewController.self)
        let settingsViewModel = SettingsViewModel()
        settingsViewModel.onOptions
            .subscribe(onNext: { self.options() })
            .disposed(by: bag)
        settingsViewModel.onLogout
            .subscribe(onCompleted: { self.logout() })
            .disposed(by: bag)
        settingsViewController.settingsViewModel = settingsViewModel
        return settingsViewController
    }

    func start() {
        navigationController.pushViewController(settingsViewController, animated: true)
    }

    private func options() {
        start(coordinator: PreferencesCoordinator(navigationController: navigationController))
    }
}
