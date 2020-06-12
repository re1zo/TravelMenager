import RxCocoa
import RxSwift

final class SignInViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var signInButton: StandardStyledUIButton!
    @IBOutlet private weak var testAccountSignInButton: StandardStyledUIButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    // MARK: - Variables

    var signInViewModel: SignInViewModel!

    private let bag = DisposeBag()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }

    private func bindUI() {
        emailTextField.rx.text
            .orEmpty
            .bind(to: signInViewModel.email)
            .disposed(by: bag)

        passwordTextField.rx.text
            .orEmpty
            .bind(to: signInViewModel.password)
            .disposed(by: bag)

        registerButton.rx.tap
            .bind(to: signInViewModel.onSingUp)
            .disposed(by: bag)

        signInButton.rx.tap
            .bind { self.signInViewModel.signIn() }
            .disposed(by: bag)

        testAccountSignInButton.rx.tap
            .bind { self.signInViewModel.reloadUser() }
            .disposed(by: bag)

        signInViewModel.notifyUser
            .bind { self.infoAlert(title: $0.0, message: $0.1) }
            .disposed(by: bag)
    }
}
