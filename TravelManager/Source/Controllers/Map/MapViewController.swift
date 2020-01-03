import RxSwift
import RxCocoa
import GoogleMaps
import GooglePlaces

final class MapViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var googleMapsView: GMSMapView!
    @IBOutlet private weak var myPlacesButton: StandardStyledUIButton!
    @IBOutlet private weak var addPlaceButton: StandardStyledUIButton!

    // MARK: - Variables

    var mapViewModel: MapViewModel!

    private let bag = DisposeBag()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }

    func bindUI() {
        addPlaceButton.rx.tap
            .bind(to: mapViewModel.onFindPlaces)
            .disposed(by: bag)

        myPlacesButton.rx.tap
            .bind(to: mapViewModel.onMyPlaces)
            .disposed(by: bag)
        
        mapViewModel.markers
            .bind { markers in
                markers.forEach { marker in
                    marker.marker.map = self.googleMapsView
                }
            }
            .disposed(by: bag)
        
        mapViewModel.selected
            .bind { self.select(marker: self.mapViewModel.markers.value[$0].marker) }
            .disposed(by: bag)
    }

    private func select(marker: GMSMarker) {
        googleMapsView.selectedMarker = marker
        googleMapsView.animate(toLocation: marker.position)
    }
}

// MARK: - GMSAutocompleteViewControllerDelegate

extension MapViewController: GMSAutocompleteViewControllerDelegate {

    func viewController(_ controller: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let mapMarker = MapMarker(place: place)
        select(marker: mapMarker.marker)
        mapViewModel.markers.acceptAppending(mapMarker)
        controller.dismiss(animated: true, completion: nil)
    }

    func viewController(_: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: This is awful and temporary solution.
        print("Error: ", error.localizedDescription)
    }

    func wasCancelled(_ controller: GMSAutocompleteViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    func didRequestAutocompletePredictions(_: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(_: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
