import RxSwift
import Firebase
import GoogleMaps

final class FirebasePlacesService: PlacesDatabaseService {
    
    func save(places: [MapMarker]) -> Single<Void> {
        Single.create { single in
            guard let userID = Auth.auth().currentUser?.uid else {
                single(.error(ApiError.userNotFoundError))
                return Disposables.create()
            }
            let database = Database.database().reference()
            let data = places.map { place in
                return [
                    "id": place.id,
                    "x": place.marker.position.latitude,
                    "y": place.marker.position.longitude,
                    "title": place.marker.title ?? "",
                    "country": place.country
                ]
            }
            database.child("users/\(userID)/places").setValue(data)
            single(.success(()))
            return Disposables.create()
        }
    }
    
    func getPlaces() -> Single<[MapMarker]> {
        Single.create { single in
            guard let userID = Auth.auth().currentUser?.uid else {
                single(.error(ApiError.userNotFoundError))
                return Disposables.create()
            }
            Database.database().reference().child("users/\(userID)/places").observe(.value) { snapshot in
                 let dupa = snapshot.value as! [[String: Any]]
                let markers = dupa.map { iteam in
                    return MapMarker(
                        id: iteam["id"] as? String ?? "",
                        title: iteam["title"] as? String ?? "",
                        country: iteam["country"] as? String ?? "",
                        x: iteam["x"] as? Double ?? 0,
                        y: iteam["y"] as? Double ?? 0)
                }
                single(.success(markers))
            }
            return Disposables.create()
        }
    }
}

