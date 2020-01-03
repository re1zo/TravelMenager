import UIKit
import RxSwift

final class SignInCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    private let bag = DisposeBag()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let signInViewController = UIStoryboard(name: "SignIn").instantiate(viewController: SignInViewController.self)
        let signInViewModel = SignInViewModel(service: GoogleAuthorisationService())

        signInViewModel.onSignIn
            .subscribe(onNext: { self.menu() })
            .disposed(by: bag)

        signInViewModel.onSingUp
            .subscribe(onNext: { self.signUp() })
            .disposed(by: bag)

        signInViewController.signInViewModel = signInViewModel
        navigationController.pushViewController(signInViewController, animated: true)
    }

    private func menu() {
        start(coordinator: MenuCoordinator(navigationController: navigationController))
    }

    private func signUp() {
        start(coordinator: SignUpCoordinator(navigationController: navigationController))
    }
}
