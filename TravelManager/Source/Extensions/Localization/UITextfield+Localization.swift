import UIKit

extension UITextField {

    @IBInspectable var l10nText: String {
        get {
            fatalError()
        }
        set {
            text = newValue.l10n()
        }
    }

    @IBInspectable var l10nPlaceholder: String {
        get {
            fatalError()
        }
        set {
            placeholder = newValue.l10n()
        }
    }
}
