import RxSwift
import RxCocoa
import Firebase

final class SignUpViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registerButton: StandardStyledUIButton!
    
    // MARK: - Variables
    
    let bag = DisposeBag()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        registerButton.rx.tap.bind { self.register(username: self.usernameTextField.text ?? "", password: self.passwordTextField.text ?? "") }.disposed(by: bag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func register(username: String, password: String) {
        Auth.auth().createUser(withEmail: username, password: password) { [weak self] data, error in
            guard let strongSelf = self else {
                return
            }
            if let error = error {
                return
            }
            if let data = data {
                strongSelf.navigationController?.popViewController(animated: true)
            }
        }
    }
}
