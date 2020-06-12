import UIKit

extension UIViewController {

    @IBInspectable var l10nTitle: String {
        get {
            fatalError()
        }
        set {
            title = newValue.l10n()
        }
    }

    @IBInspectable var l10nTapBarTitle: String {
        get {
            fatalError()
        }
        set {
            tabBarItem.title = newValue.l10n()
        }
    }
}
