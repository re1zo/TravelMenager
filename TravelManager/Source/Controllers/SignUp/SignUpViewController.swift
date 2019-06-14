import UIKit
import Firebase

final class SignUpViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registerButton: StandardStyledUIButton!
    
    // MARK: Actions

    @IBAction private func registerButtonClicked() {
        register(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    // MARK: Life cycle

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
