import UIKit
import RxSwift

final class SignUpCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    private let bag = DisposeBag()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let signUpViewController = UIStoryboard(name: "SignUp").instantiate(viewController: SignUpViewController.self)
        signUpViewController.rx.didMoveToParentViewController.subscribe(onNext: { controller in
            if controller == nil {
                self.end()
            }
        })
            .disposed(by: bag)

        let signUpViewModel = SignUpViewModel(service: GoogleAuthorisationService())
        signUpViewModel.onRegister
            .subscribe(onCompleted: { self.back() })
            .disposed(by: bag)
        signUpViewController.signUpViewModel = signUpViewModel
        navigationController.pushViewController(signUpViewController, animated: true)
    }
}
