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
        let storyboard = UIStoryboard(name: "SignUp", bundle: .main)
        let signUpViewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController.rx.didMoveToParentViewController.subscribe(onNext: { controller in
            if controller == nil {
                self.end()
            }
        }).disposed(by: bag)
        let signUpViewModel = SignUpViewModel(service: GoogleAuthorisationService())
        signUpViewModel.registered.subscribe(onCompleted: { self.dismiss() }).disposed(by: bag)
        signUpViewController.signUpViewModel = signUpViewModel
        navigationController.pushViewController(signUpViewController, animated: true)
    }
}
