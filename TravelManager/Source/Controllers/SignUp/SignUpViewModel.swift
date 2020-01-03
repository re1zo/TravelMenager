import RxSwift
import RxRelay

final class SignUpViewModel {

    let service: AuthorisationService

    let email = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    let onRegister = PublishSubject<Void>()

    private let bag = DisposeBag()

    init(service: AuthorisationService) {
        self.service = service
    }

    func register() {
        service.signUp(email: email.value, password: password.value)
            .subscribe(
                onSuccess: { [weak self] _ in
                    self?.onRegister.onCompleted()
                },
                onError: { [weak self] error in
                    debugPrint(error.localizedDescription)
                }
            )
            .disposed(by: bag)
    }
}
