import UIKit

extension UIStoryboard {

    convenience init(name: String) {
        self.init(name: name, bundle: .main)
    }

    func instantiate<T>(viewController _: T.Type) -> T {
        instantiateViewController(withIdentifier: "\(T.self)") as! T
    }
}
