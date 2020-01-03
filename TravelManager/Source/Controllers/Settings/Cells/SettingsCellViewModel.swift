import RxRelay

final class SettingsCellViewModel {

    let title: BehaviorRelay<String>

    init(title: String) {
        self.title = BehaviorRelay(value: title)
    }
}
