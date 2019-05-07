import UIKit
import GoogleMaps

final class MapViewController: UIViewController {

    @IBOutlet private weak var googleMapsView: GMSMapView!
    
    @IBAction private func addPlaceButtonClicked() {
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocationCoordinate2DMake(52.520736, 13.409423)
        let marker = GMSMarker(position: initialLocation)
        marker.title = "Berlin"
        marker.map = googleMapsView
    }
}
