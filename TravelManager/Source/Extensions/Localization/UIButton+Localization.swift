import UIKit

extension UIButton {

    @IBInspectable var l10nText: String {
        get {
            fatalError()
        }
        set {
            setTitle(newValue.l10n(), for: .normal)
        }
    }
}
