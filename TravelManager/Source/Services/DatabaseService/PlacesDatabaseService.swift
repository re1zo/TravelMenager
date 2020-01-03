import RxSwift
import GoogleMaps

protocol PlacesDatabaseService {
    
    func save(places: [MapMarker]) -> Single<Void>
    func getPlaces() -> Single<[MapMarker]>
}
