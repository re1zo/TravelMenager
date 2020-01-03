import UIKit
import RxSwift

final class SettingsTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    private let bag = DisposeBag()

    var viewModel: SettingsCellViewModel! {
        didSet {
            viewModel.title.bind(to: titleLabel.rx.text).disposed(by: bag)
        }
    }
}
