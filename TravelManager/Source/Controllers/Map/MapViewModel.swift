import RxSwift
import RxRelay

final class MapViewModel {

    let service: PlacesDatabaseService

    let onFindPlaces = PublishSubject<Void>()
    let onMyPlaces = PublishSubject<Void>()

    let markers = BehaviorRelay<[MapMarker]>(value: [])
    let selected = PublishSubject<MapMarker>()

    private let bag = DisposeBag()

    init(service: PlacesDatabaseService) {
        self.service = service

        let reload = service.reloadPlaces()
        reload.subscribe(onSuccess: { markers in
            self.markers.accept(markers)
        }, onError: { _ in
            // TODO: Alert implementation
        })
            .disposed(by: bag)

        markers.skipUntil(reload.asObservable())
            .subscribe(onNext: { markers in
                self.service.save(places: markers)
                    .subscribe(
                        onSuccess: { _ in },
                        onError: { _ in
                            // TODO: Alert implementation
                        }
                    )
                    .disposed(by: self.bag)
            })
            .disposed(by: bag)
    }

    func createMarker(id: String?, title: String?, country: String, x: Double, y: Double) {
        let marker = MapMarker(id: id, title: title, country: country, x: x, y: y)
        markers.acceptAppending(marker)
        selected.onNext(marker)
    }
}
