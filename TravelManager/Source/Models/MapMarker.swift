import GoogleMaps
import GooglePlaces

struct MapMarker {
    
    let id: String
    let marker: GMSMarker
    
    init(place: GMSPlace) {
        self.id = place.placeID ?? ""
        let marker = GMSMarker()
        marker.title = place.name
        marker.position = place.coordinate
        self.marker = marker
    }
}

