import RxSwift
import RxRelay

final class SignUpViewModel {

    let service: AuthorisationService

    let email = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    let onRegister = PublishSubject<Void>()
    let notifyUser = PublishSubject<(String, String)>()

    private let bag = DisposeBag()

    init(service: AuthorisationService) {
        self.service = service
    }

    func register() {
        service.signUp(email: email.value, password: password.value).observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] info in
                    self?.notifyUser.onNext(("Success", info))
                    self?.onRegister.onCompleted()
                },
                onError: { [weak self] error in
                    self?.notifyUser.onNext(("Error", error.localizedDescription))
                }
            )
            .disposed(by: bag)
    }
}
