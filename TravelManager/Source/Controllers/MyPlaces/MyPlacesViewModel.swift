import RxRelay
import RxSwift

final class MyPlacesViewModel {

    let onUsedPlaces = PublishSubject<Void>()

    let selected: PublishSubject<MapMarker>
    let markers: BehaviorRelay<[MapMarker]>
    lazy var shouldShowPlaceholder = BehaviorSubject(value: !markers.value.isEmpty)

    private let bag = DisposeBag()

    init(markers: BehaviorRelay<[MapMarker]>, selected: PublishSubject<MapMarker>) {
        self.markers = markers
        self.selected = selected

        markers.subscribe(onNext: { markers in
            self.shouldShowPlaceholder.onNext(!markers.isEmpty)
        })
            .disposed(by: bag)
    }

    func selected(row: Int) {
        selected.onNext(markers.value[row])
    }

    func remove(marker: MapMarker) {
        marker.marker.map = nil
        markers.accept(markers.value.filter { $0 !== marker })
    }
}
