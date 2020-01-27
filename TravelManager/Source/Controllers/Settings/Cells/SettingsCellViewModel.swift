import RxSwift

final class SettingsCellViewModel {

    let title: Observable<String>

    init(setting: SettingsItem) {
        title = Observable.just(setting.rawValue)
    }
}
