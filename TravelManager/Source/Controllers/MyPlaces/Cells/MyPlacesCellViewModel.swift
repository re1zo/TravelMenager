import RxSwift

final class MyPlacesCellViewModel {

    let title: Observable<String>
    let country: Observable<String>
    let removePlace = PublishSubject<Void>()

    init(marker: MapMarker) {
        title = Observable.just(marker.googleMarker.title ?? "")
        country = Observable.just(marker.country)
    }
}
