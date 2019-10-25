import UIKit

protocol Coordinator: class {

    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }

    func start()
    func end()
    func dismiss()
}

extension Coordinator {

    func end() {
        parentCoordinator?.childCoordinators = childCoordinators.filter { $0 !== self }
    }

    func dismiss() {
        end()
        navigationController.popViewController(animated: true)
    }
}
