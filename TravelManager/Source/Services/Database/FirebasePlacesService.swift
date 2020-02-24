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
            let data = places.map(\.data)
            database.child("users/\(userID)/places").setValue(data)
            single(.success(()))
            return Disposables.create()
        }
    }

    func reloadPlaces() -> Single<[MapMarker]> {
        Single.create { single in
            guard let userID = Auth.auth().currentUser?.uid else {
                single(.error(ApiError.userNotFoundError))
                return Disposables.create()
            }
            Database.database().reference().child("users/\(userID)/places").observe(.value) { snapshot in
                guard let value = snapshot.value as? [[String: Any]],
                    let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []),
                    let markers = try? JSONDecoder().decode([MapMarker].self, from: jsonData)
                else {
                    single(.success([]))
                    return
                }

                single(.success(markers))
            }
            return Disposables.create()
        }
    }
}
