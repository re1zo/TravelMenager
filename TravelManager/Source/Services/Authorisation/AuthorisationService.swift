import RxSwift

protocol AuthorisationService {
    func signIn(email: String, password: String) -> Single<AppUser>
    func signUp(email: String, password: String) -> Single<String>
}
