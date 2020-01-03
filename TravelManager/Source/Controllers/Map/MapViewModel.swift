import RxSwift
import RxRelay

final class MapViewModel {
    
    let service: PlacesDatabaseService
    
    let onFindPlaces = PublishSubject<Void>()
    let onMyPlaces = PublishSubject<Void>()
    
    let markers = BehaviorRelay<[MapMarker]>(value: [])
    let selected = PublishSubject<Int>()
    let save = PublishSubject<Void>()

    private let bag = DisposeBag()
    
    init(service: PlacesDatabaseService) {
        self.service = service

        service.getPlaces()
            .subscribe(onSuccess: { markers in
                self.markers.accept(markers)
            }, onError: { _ in
                
            })
            .disposed(by: bag)
        
        markers.subscribe(onNext: { markers in
            self.service.save(places: markers).subscribe(onSuccess: { _ in } , onError: { _ in }).disposed(by: self.bag)
        }).disposed(by: bag)
    }
}
