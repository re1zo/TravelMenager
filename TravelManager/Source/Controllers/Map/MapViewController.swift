import RxSwift
import RxCocoa
import GoogleMaps
import GooglePlaces

final class MapViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var addPlaceButton: StandardStyledUIButton!
    @IBOutlet private weak var googleMapsView: GMSMapView!

    // MARK: - Variables

    private var markers: [GMSMarker] = []

    private let bag = DisposeBag()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addPlaceButton.rx.tap.bind { self.findPlace() }.disposed(by: bag)
    }

    private func findPlace() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        let fields = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleteController.placeFields = fields

        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        present(autocompleteController, animated: true, completion: nil)
    }

    private func addMarker(coordinate: CLLocationCoordinate2D, title: String) {
        let marker = GMSMarker()
        marker.position = coordinate
        marker.title = title
        marker.map = googleMapsView
        markers.append(marker)
    }

    private func remove(marker: GMSMarker?) {
        guard let marker = marker else {
            return
        }
        marker.map = nil
        markers.removeAll { $0 == marker }
    }
}

// MARK: - GMSAutocompleteViewControllerDelegate

extension MapViewController: GMSAutocompleteViewControllerDelegate {

    func viewController(_: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        addMarker(coordinate: place.coordinate, title: place.name ?? "")
        dismiss(animated: true, completion: nil)
    }

    func viewController(_: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }

    func wasCancelled(_: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }

    func didRequestAutocompletePredictions(_: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(_: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
