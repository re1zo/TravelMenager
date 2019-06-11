import UIKit
import Firebase

final class SignInViewController: UIViewController {
   
    // MARK: - Outlets
    
    @IBOutlet private weak var usernameButton: UITextField!
    @IBOutlet private weak var passwordButton: UITextField!
    
    // MARK: - Actions
    
    @IBAction private func signInButtonClicked() {
        signIn(username: usernameButton.text ?? "", password: usernameButton.text ?? "")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    func signIn(username: String, password: String) {
//        Auth.auth().signIn(withEmail: username, password: password) { [weak self] user, error in
//            debugPrint(user)
//            debugPrint(error)
//            guard let strongSelf = self,
//                let user = user
//            else {
//                return
//            }
//            strongSelf.performSegue(withIdentifier: "showMenu")
//        }
        
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
