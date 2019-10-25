import UIKit

final class StandardStyledUIButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 3)
    }
}
