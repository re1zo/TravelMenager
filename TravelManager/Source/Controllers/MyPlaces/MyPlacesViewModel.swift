import RxRelay
import RxSwift
import GoogleMaps

final class MyPlacesViewModel {

    let selected: PublishSubject<Int>

    let onUsedPlaces = PublishSubject<Void>()
    private let markers: BehaviorRelay<[MapMarker]>

    var placesViewModels: Observable<[MyPlacesCellViewModel]> {
        Observable.of(markers.value.map { MyPlacesCellViewModel(title: $0.marker.title ?? "") })
    }
    
    init(markers: BehaviorRelay<[MapMarker]>, selected: PublishSubject<Int>) {
        self.markers = markers
        self.selected = selected
    }
}
