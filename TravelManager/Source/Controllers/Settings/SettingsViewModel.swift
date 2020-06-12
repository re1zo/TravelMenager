import RxSwift
import RxRelay

final class SettingsViewModel {

    let onLogout = PublishSubject<Void>()
    let onOptions = PublishSubject<Void>()

    let email = Observable.just(AppUser().current?.email ?? "")
    let settings = BehaviorRelay(value: SettingsItem.allCases)

    func selected(setting: Int) {
        switch settings.value[setting] {
        case .preferences:
            onOptions.onNext(())
        case .logout:
            AppUser().signOut()
            onLogout.onCompleted()
        }
    }
}
