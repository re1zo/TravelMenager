import RxSwift
import Firebase

final class GoogleAuthorizationService: AuthorizationService {

    func signIn(email: String, password: String) -> Single<AppUser> {
        Single<AppUser>.create { single in
            Auth.auth().signIn(withEmail: email, password: password) { userInfo, error in
                if let error = error {
                    single(.error(error))
                    return
                }

                guard let _ = userInfo else {
                    single(.error(ApiError.userNotFoundError))
                    return
                }
                single(.success(AppUser()))
            }
            return Disposables.create()
        }
    }

    func signUp(email: String, password: String) -> Single<String> {
        Single<String>.create { single in
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if let error = error {
                    single(.error(error))
                    return
                }
                guard let _ = user else {
                    single(.error(ApiError.userNotFoundError))
                    return
                }
                try? Auth.auth().signOut()
                single(.success("User regiestred."))
            }
            return Disposables.create()
        }
    }
}
