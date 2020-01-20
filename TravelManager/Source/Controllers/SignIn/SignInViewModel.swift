import RxSwift
import RxRelay

final class SignInViewModel {

    let service: AuthorisationService

    let onSignIn = PublishSubject<Void>()
    let onSingUp = PublishSubject<Void>()

    let email = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")

    private let bag = DisposeBag()

    init(service: AuthorisationService) {
        self.service = service
    }
    
    func signIn() {
            service.signIn(email: email.value , password: password.value)
                .subscribe(
                    onSuccess: { [weak self] _ in
                        self?.onSignIn.onNext(())
                    },
                    onError: { _ in
                        // TODO: Error alert implementation
                    }
                )
                .disposed(by: bag)
    }
    
    func reloadUser() {
        service.signIn(email: "ifenix@gazeta.pl", password: "Test1234")
            .subscribe(
                onSuccess: { [weak self] _ in
                    self?.onSignIn.onNext(())
                },
                onError: { _ in
                    // TODO: Error alert implementation
                }
            )
            .disposed(by: bag)
    }
}
