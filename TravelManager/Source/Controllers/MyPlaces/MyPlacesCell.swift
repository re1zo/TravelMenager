import UIKit

final class MyPlacesCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.backgroundColor = CoolColors.random
        layer.cornerRadius = 20
        layer.borderWidth = 0.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 15)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }
}
