import UIKit
import Firebase

final class SignInViewController: UIViewController {
   
    // MARK: - Outlets
    
    @IBOutlet private weak var signInButton: UIButton! {
        didSet {
            signInButton.applyShadow()
        }
    }
    
    @IBOutlet private weak var testAccountSignInButton: UIButton! {
        didSet {
            testAccountSignInButton.applyShadow()
        }
    }
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    // MARK: - Actions
    
    @IBAction private func signInButtonClicked() {
        signIn(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    @IBAction private func testAccountSignInButtonClicked() {
        testAccountSignIn()
    }
    
    // MARK: Methods

    private func signIn(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { [weak self] user, error in
            guard let strongSelf = self,
                let user = user
            else {
                return
            }
            
            strongSelf.performSegue(withIdentifier: "showMenu")
        }
    }
    
    private func testAccountSignIn() {
        Auth.auth().signInAnonymously() { [weak self] authResult, error in
            guard let strongSelf = self,
                let authResult = authResult
            else {
                    return
            }
            strongSelf.performSegue(withIdentifier: "showMenu")
        }
    }
}
