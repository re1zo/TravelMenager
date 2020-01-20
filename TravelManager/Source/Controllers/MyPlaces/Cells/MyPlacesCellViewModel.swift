import RxSwift

final class MyPlacesCellViewModel {

    let title: BehaviorSubject<String>
    let country: BehaviorSubject<String>

    init(title: String, country: String) {
        self.title = BehaviorSubject(value: title)
        self.country = BehaviorSubject(value: country)
    }
}
