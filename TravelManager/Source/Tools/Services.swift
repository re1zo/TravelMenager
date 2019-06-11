import Firebase
import GoogleMaps

final class Configure {

    func configure() {
        FirebaseApp.configure()
        GMSServices.provideAPIKey(Settings.googleMapsApiKey)
    }
}
