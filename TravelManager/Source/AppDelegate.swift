import UIKit

@UIApplicationMain
 final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Services().configure()

        coordinator = MainCoordinator()
        window = coordinator?.window
        coordinator?.start()

        return true
    }
}
