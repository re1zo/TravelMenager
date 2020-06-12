import RxSwift
import GoogleMaps

protocol PlacesDatabaseService {

    func save(places: [MapMarker]) -> Single<Void>
    func reloadPlaces() -> Single<[MapMarker]>
}
