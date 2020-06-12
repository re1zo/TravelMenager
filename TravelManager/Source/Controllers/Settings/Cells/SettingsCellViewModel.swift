import RxSwift

final class SettingsCellViewModel {

    let title: Observable<String>

    init(setting: SettingsItem) {
        title = Observable.just("ui.settings.\(setting.rawValue)".l10n())
    }
}
