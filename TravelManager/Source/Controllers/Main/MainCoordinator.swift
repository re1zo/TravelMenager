import UIKit
import RxSwift

final class MainCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    private(set) var window = UIWindow(frame: UIScreen.main.bounds)
    private let bag = DisposeBag()

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        mainViewController.rx.viewWillAppear.subscribe { [weak self] _ in
            self?.signIn()
        }.disposed(by: bag)
        navigationController.pushViewController(mainViewController, animated: true)
    }

    private func signIn() {
        let signInCoordinator = SignInCoordinator(navigationController: navigationController)
        childCoordinators.append(signInCoordinator)
        signInCoordinator.parentCoordinator = self
        signInCoordinator.start()
    }
}
