import UIKit

extension UILabel {

    @IBInspectable var l10nText: String {
        get {
            fatalError()
        }
        set {
            text = newValue.l10n()
        }
    }
}
