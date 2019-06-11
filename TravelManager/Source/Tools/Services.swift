import Firebase
import GoogleMaps

final class Services {

    func configure() {
        FirebaseApp.configure()
        GMSServices.provideAPIKey(Settings.googleMapsApiKey)
    }
}
