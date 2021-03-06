import UIKit
import RxSwift
import RxRelay
import GoogleMaps

final class MyPlacesCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    private let bag = DisposeBag()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let myPlacesViewController = UIStoryboard(name: "MyPlaces").instantiate(viewController: MyPlacesViewController.self)
        let myPlacesViewModel = MyPlacesViewModel(markers: BehaviorRelay<[MapMarker]>(value: []), selected: PublishSubject<MapMarker>())
        myPlacesViewModel.onUsedPlaces
            .subscribe(onNext: { self.dismiss() })
            .disposed(by: bag)
        myPlacesViewController.myPlacesViewModel = myPlacesViewModel
        navigationController.present(myPlacesViewController, animated: true)
    }

    func start(with markers: BehaviorRelay<[MapMarker]>, selected: PublishSubject<MapMarker>) {
        let myPlacesViewController = UIStoryboard(name: "MyPlaces").instantiate(viewController: MyPlacesViewController.self)
        let myPlacesViewModel = MyPlacesViewModel(markers: markers, selected: selected)
        myPlacesViewModel.onUsedPlaces
            .subscribe(onNext: { self.dismiss() })
            .disposed(by: bag)
        myPlacesViewController.myPlacesViewModel = myPlacesViewModel
        navigationController.present(myPlacesViewController, animated: true)
    }
}
