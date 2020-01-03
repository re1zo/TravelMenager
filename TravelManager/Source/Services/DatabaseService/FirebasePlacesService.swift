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
            let database = Database.database().reference()
            
            database.child("users/\(userID)/places").setValue([])
            return Disposables.create()
        }
    }
}

