import UIKit

final class StandardStyledUIButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.shadowColor = traitCollection.userInterfaceStyle == .light ? UIColor.darkGray.cgColor : UIColor.white.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.shadowColor = traitCollection.userInterfaceStyle == .light ? UIColor.darkGray.cgColor : UIColor.white.cgColor
    }
}
