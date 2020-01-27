import GoogleMaps
import GooglePlaces

class MapMarker: Decodable {

    let id: String
    let country: String
    let marker: GMSMarker

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
        self.marker = marker
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
        self.marker = marker
    }

    var data: [String: Any] {
        return [
            "id": id,
            "x": marker.position.latitude,
            "y": marker.position.longitude,
            "title": marker.title ?? "",
            "country": country,
        ]
    }
}
