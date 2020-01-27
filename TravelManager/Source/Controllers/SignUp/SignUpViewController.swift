import RxCocoa
import RxSwift

final class SignUpViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registerButton: StandardStyledUIButton!

    // MARK: - Variables

    var signUpViewModel: SignUpViewModel!

    private let bag = DisposeBag()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    private func bindUI() {
        emailTextField.rx.text
            .orEmpty
            .bind(to: signUpViewModel.email)
            .disposed(by: bag)

        passwordTextField.rx.text
            .orEmpty
            .bind(to: signUpViewModel.password)
            .disposed(by: bag)

        registerButton.rx.tap
            .bind { self.signUpViewModel.register() }
            .disposed(by: bag)
    }
}
