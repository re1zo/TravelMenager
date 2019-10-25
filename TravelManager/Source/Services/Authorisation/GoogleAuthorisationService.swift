import RxSwift
import Firebase

final class GoogleAuthorisationService: AuthorisationService {

    func signIn(email: String, password: String) -> Single<AppUser> {
        return Single<AppUser>.create { single in
            Auth.auth().signIn(withEmail: email, password: password) { userInfo, error in
                if let error = error {
                    single(.error(error))
                    return
                }

                guard let _ = userInfo else {
                    single(.error(ApiError.dataError))
                    return
                }
                single(.success(AppUser()))
            }
            return Disposables.create()
        }
    }
    
    func signUp(email: String, password: String) -> Single<String> {
        return Single<String>.create { single in
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if let error = error {
                    single(.error(error))
                    return
                }
                guard let _ = user else {
                    single(.error(ApiError.dataError))
                    return
                }
                try? Auth.auth().signOut()
                single(.success("USER REGIESTRED"))
            }
            return Disposables.create()
        }
    }
}
