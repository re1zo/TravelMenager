import UIKit
import RxSwift

final class MyPlacesCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var cityImageView: UIImageView!

    var viewModel: MyPlacesCellViewModel! {
        didSet {
            viewModel.title.bind(to: titleLabel.rx.text).disposed(by: bag)
            viewModel.country.bind(to: countryLabel.rx.text).disposed(by: bag)
        }
    }

    private let bag = DisposeBag()

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
