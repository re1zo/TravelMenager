import UIKit

protocol Coordinator: class {

    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }

    func start()
}

extension Coordinator {

    func start(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }

    func end() {
        parentCoordinator?.childCoordinators = childCoordinators.filter { $0 !== self }
    }

    func logout() {
        parentCoordinator?.childCoordinators = []
        navigationController.popViewController(animated: true)
    }

    func back() {
        end()
        navigationController.popViewController(animated: true)
    }

    func dismiss() {
        end()
        navigationController.dismiss(animated: true)
    }
}
