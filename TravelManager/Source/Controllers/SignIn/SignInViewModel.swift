import RxSwift
import RxRelay

final class SignInViewModel {

    let service: AuthorisationService

    let signIn = PublishSubject<Void>()
    let signUp = PublishSubject<Void>()
    
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

    private let bag = DisposeBag()

    init(service: AuthorisationService) {
        self.service = service
    }

    func reloadUser() {
        service.signIn(email: "ifenix@gazeta.pl", password: "Test1234")
            .subscribe(
                onSuccess: { [weak self] user in
                    self?.signIn.onCompleted()
                },
                onError: { _ in
                    //TODO: Error alert implementation
            }
            )
            .disposed(by: bag)
    }
}
