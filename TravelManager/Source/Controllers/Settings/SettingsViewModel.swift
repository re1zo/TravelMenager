import RxSwift

final class SettingsViewModel {

    let onLogout = PublishSubject<Void>()
    let onOptions = PublishSubject<Void>()

    let email = Observable.just(AppUser().current?.email ?? "")

    var items: Observable<[SettingsCellViewModel]> {
        Observable.from(optional: SettingsItem.allCases.map { SettingsCellViewModel(title: $0.rawValue) })
    }

    func selected(setting: Int) {
        switch SettingsItem.allCases[setting] {
        case .preferences:
            onOptions.onNext(())
        case .logout:
            AppUser().signOut()
            onLogout.onCompleted()
        }
    }
}
