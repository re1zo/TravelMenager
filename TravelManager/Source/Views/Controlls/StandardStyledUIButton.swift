import UIKit

final class StandardStyledUIButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
}
