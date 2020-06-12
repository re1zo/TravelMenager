import UIKit
import RxSwift
import RxRelay
import GoogleMaps
import GooglePlaces

final class MapCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    private let bag = DisposeBag()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    var mapViewController: UIViewController {
        let mapViewController = UIStoryboard(name: "Map").instantiate(viewController: MapViewController.self)
        let mapViewModel = MapViewModel(service: FirebasePlacesService())
        mapViewModel.onFindPlaces
            .subscribe(onNext: { self.findPlace(delegate: mapViewController) })
            .disposed(by: bag)
        mapViewModel.onMyPlaces
            .subscribe(onNext: { self.myPlaces(markers: mapViewModel.markers, selected: mapViewModel.selected) })
            .disposed(by: bag)
        mapViewController.mapViewModel = mapViewModel
        return mapViewController
    }

    func start() {
        navigationController.pushViewController(mapViewController, animated: true)
    }

    private func myPlaces(markers: BehaviorRelay<[MapMarker]>, selected: PublishSubject<MapMarker>) {
        let coordinator = MyPlacesCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start(with: markers, selected: selected)
    }

    private func findPlace(delegate: GMSAutocompleteViewControllerDelegate) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = delegate

        let fields = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.addressComponents.rawValue) | UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleteController.placeFields = fields

        let filter = GMSAutocompleteFilter()
        filter.type = .city
        autocompleteController.autocompleteFilter = filter
        navigationController.present(autocompleteController, animated: true, completion: nil)
    }
}
