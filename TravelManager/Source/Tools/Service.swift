import Firebase
import GoogleMaps
import GooglePlaces

final class Service {

    func configure() {
        FirebaseApp.configure()
        GMSServices.provideAPIKey(Settings.googleMapsPlatformApiKey)
        GMSPlacesClient.provideAPIKey(Settings.googleMapsPlatformApiKey)
    }
}
