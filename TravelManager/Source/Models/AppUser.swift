import Firebase

final class AppUser {

    let current = Auth.auth().currentUser

    func signOut() {
        try? Auth.auth().signOut()
    }
}
