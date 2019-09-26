import RxSwift
import Firebase

final class SignInViewController: UIViewController {
   
    // MARK: - Outlets
    
    @IBOutlet private weak var signInButton: StandardStyledUIButton!
    @IBOutlet private weak var testAccountSignInButton: StandardStyledUIButton!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    // MARK: - Variables
    
    private let bag = DisposeBag()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.rx.tap.bind { self.signIn(username: self.usernameTextField.text ?? "", password: self.passwordTextField.text ?? "") }.disposed(by: bag)
        testAccountSignInButton.rx.tap.bind { self.signIn(username: "ifenix@gazeta.pl", password: "Test1234") }.disposed(by: bag)
    }
    
    private func signIn(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { [weak self] user, error in
            guard let strongSelf = self, let user = user else {
                return
            }

            strongSelf.performSegue(withIdentifier: "showMenu")
        }
    }
}
