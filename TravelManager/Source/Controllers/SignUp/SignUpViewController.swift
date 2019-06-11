import UIKit
import Firebase

final class SignUpViewController: UIViewController {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton! {
        didSet {
            registerButton.applyShadow()
        }
    }
    
    @IBAction private func registerButtonClicked() {
        register(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
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
//        Auth.auth().createUser(withEmail: username, password: password) { [weak self] error in
//        }
    }
}
