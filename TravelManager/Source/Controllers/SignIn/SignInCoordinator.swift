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
        let storyboard = UIStoryboard(name: "SignIn", bundle: .main)
        let signInViewController = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        let signInViewModel = SignInViewModel(service: GoogleAuthorisationService())
        
        signInViewModel.signIn.subscribe(onCompleted: { self.menu() }).disposed(by: bag)
        signInViewModel.signUp.subscribe(onNext: { self.signUp() }).disposed(by: bag)

        signInViewController.signInViewModel = signInViewModel
        navigationController.pushViewController(signInViewController, animated: true)
    }

    private func menu() {
        let menuCoordinator = MenuCoordinator(navigationController: navigationController)
        childCoordinators.append(menuCoordinator)
        menuCoordinator.parentCoordinator = self
        menuCoordinator.start()
    }

    private func signUp() {
        let signUpCoordinator = SignUpCoordinator(navigationController: navigationController)
        childCoordinators.append(signUpCoordinator)
        signUpCoordinator.parentCoordinator = self
        signUpCoordinator.start()
    }
}
