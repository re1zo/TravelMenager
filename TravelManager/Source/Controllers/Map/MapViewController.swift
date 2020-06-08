import RxCocoa
import RxSwift
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
        updateMapStyle()
        bindUI()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateMapStyle()
    }

    private func bindUI() {
        addPlaceButton.rx.tap
            .bind(to: mapViewModel.onFindPlaces)
            .disposed(by: bag)

        myPlacesButton.rx.tap
            .bind(to: mapViewModel.onMyPlaces)
            .disposed(by: bag)

        mapViewModel.markers
            .bind { markers in
                markers.forEach { marker in
                    marker.googleMarker.map = self.googleMapsView
                }
            }
            .disposed(by: bag)

        mapViewModel.selected
            .bind { self.select(marker: $0.googleMarker) }
            .disposed(by: bag)
    }

    private func select(marker: GMSMarker) {
        googleMapsView.selectedMarker = marker
        googleMapsView.animate(toLocation: marker.position)
    }

    private func updateMapStyle() {
        if traitCollection.userInterfaceStyle == .dark,
            let styleURL = Bundle.main.url(forResource: "MapNightTheme", withExtension: "json"),
            let style = try? GMSMapStyle(contentsOfFileURL: styleURL) {
            googleMapsView.mapStyle = style
        } else {
            googleMapsView.mapStyle = nil
        }
    }
}

// MARK: - GMSAutocompleteViewControllerDelegate

extension MapViewController: GMSAutocompleteViewControllerDelegate {

    func viewController(_ controller: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let country = place.addressComponents?.first(where: { $0.types.first == "country" })?.name ?? ""
        mapViewModel.createMarker(
            title: place.name,
            country: country,
            x: place.coordinate.latitude,
            y: place.coordinate.longitude
        )
        controller.dismiss(animated: true, completion: nil)
    }

    func viewController(_: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        infoAlert(message: error.localizedDescription)
    }

    func wasCancelled(_ controller: GMSAutocompleteViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
