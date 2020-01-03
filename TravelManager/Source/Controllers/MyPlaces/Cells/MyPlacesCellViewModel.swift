import RxSwift

final class MyPlacesCellViewModel {

    let title: BehaviorSubject<String>

    init(title: String) {
        self.title = BehaviorSubject(value: title)
    }
}
