import GoogleMaps
import GooglePlaces

struct MapMarker {
    
    let id: String
    let country: String
    let marker: GMSMarker
    
    init(place: GMSPlace) {
        self.id = place.placeID ?? ""
        let marker = GMSMarker()
        marker.title = place.name
        marker.position = place.coordinate
        self.country = place.addressComponents?.first { $0.name == "country"}?.name ?? ""
        self.marker = marker
    }
    
    init(id: String, title: String, country: String, x: Double, y: Double) {
        self.id = id
        self.country = country
        let marker = GMSMarker()
        marker.title = title
        marker.position = CLLocationCoordinate2D(latitude: x, longitude: y)
        self.marker = marker
    }
}

