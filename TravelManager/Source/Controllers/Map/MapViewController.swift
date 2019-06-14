import UIKit
import GoogleMaps

final class MapViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet private weak var addPlaceButton: StandardStyledUIButton!
    @IBOutlet private weak var googleMapsView: GMSMapView!
    
    // MARK: Actions

    @IBAction private func addPlaceButtonClicked() {
     
    }
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocationCoordinate2DMake(52.520736, 13.409423)
        let marker = GMSMarker(position: initialLocation)
        marker.title = "Berlin"
        marker.map = googleMapsView
    }
}
