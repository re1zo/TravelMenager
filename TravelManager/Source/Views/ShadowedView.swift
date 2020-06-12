import UIKit

final class ShadowedView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: -5)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.shadowColor = traitCollection.userInterfaceStyle == .light ? UIColor.darkGray.cgColor : UIColor.white.cgColor
    }
}
