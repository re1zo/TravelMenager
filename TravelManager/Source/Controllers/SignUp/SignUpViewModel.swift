import RxSwift
import RxRelay

final class SignUpViewModel {
    
    let service: AuthorisationService
    
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let registered = PublishSubject<Void>()

    private let bag = DisposeBag()
    
    init(service: AuthorisationService) {
        self.service = service
    }
    
    func register() {
        service.signUp(email: email.value, password: password.value).subscribe(
            onSuccess: { [weak self] text in
                self?.registered.onCompleted()
            },
            onError: { [weak self] error in
                debugPrint(error.localizedDescription)
            }).disposed(by: bag)
    }
}
