import UIKit
import RxSwift

final class SceneCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    let window = UIWindow(frame: UIScreen.main.bounds)
    private let bag = DisposeBag()

    init(windowScene: UIWindowScene, navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        window.windowScene = windowScene
    }

    func start() {
        let mainViewController = UIStoryboard(name: "Main").instantiate(viewController: MainViewController.self)
        mainViewController.rx.viewWillAppear
            .subscribe { _ in
                self.signIn()
            }
            .disposed(by: bag)
        navigationController.pushViewController(mainViewController, animated: true)
    }

    private func signIn() {
        start(coordinator: SignInCoordinator(navigationController: navigationController))
    }
}
