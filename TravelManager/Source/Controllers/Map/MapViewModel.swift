import RxSwift
import RxRelay

final class MapViewModel {

    let service: PlacesDatabaseService

    let onFindPlaces = PublishSubject<Void>()
    let onMyPlaces = PublishSubject<Void>()

    let markers = BehaviorRelay<[MapMarker]>(value: [])
    let selected = PublishSubject<MapMarker>()
    let notifyUser = PublishSubject<(String, String)>()

    private let bag = DisposeBag()

    init(service: PlacesDatabaseService) {
        self.service = service

        let reload = service.reloadPlaces()
        reload.subscribe(onSuccess: { markers in
            self.markers.accept(markers)
        }, onError: { [weak self] error in
            self?.notifyUser.onNext(("Error", error.localizedDescription))
        })
            .disposed(by: bag)

        markers.skipUntil(reload.asObservable())
            .subscribe(onNext: { markers in
                self.service.save(places: markers)
                    .subscribe(
                        onSuccess: { _ in },
                        onError: { [weak self] error in
                            self?.notifyUser.onNext(("Error", error.localizedDescription))
                        }
                    )
                    .disposed(by: self.bag)
            })
            .disposed(by: bag)
    }

    func createMarker(title: String?, country: String, x: Double, y: Double) {
        let marker = MapMarker(title: title, country: country, x: x, y: y)
        markers.acceptAppending(MapMarker(title: title, country: country, x: x, y: y))
        selected.onNext(marker)
    }
}
