import GoogleMaps
import GooglePlaces

class MapMarker: Decodable {

    let id: String
    let country: String
    let googleMarker: GMSMarker

    enum CodingKeys: String, CodingKey {
        case id
        case country
        case title
        case x
        case y
    }

    init(id: String?, title: String?, country: String, x: Double, y: Double) {
        self.id = id ?? ""
        self.country = country
        let marker = GMSMarker()
        marker.title = title
        marker.position = CLLocationCoordinate2D(latitude: x, longitude: y)
        googleMarker = marker
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        country = try values.decode(String.self, forKey: .country)
        let marker = GMSMarker()
        marker.title = try values.decode(String.self, forKey: .title)
        marker.position = CLLocationCoordinate2D(
            latitude: try values.decode(Double.self, forKey: .x),
            longitude: try values.decode(Double.self, forKey: .y)
        )
        googleMarker = marker
    }

    var data: [String: Any] {
        [
            "id": id,
            "x": googleMarker.position.latitude,
            "y": googleMarker.position.longitude,
            "title": googleMarker.title ?? "",
            "country": country,
        ]
    }
}
