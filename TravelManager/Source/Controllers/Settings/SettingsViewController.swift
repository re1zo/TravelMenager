import RxCocoa
import RxSwift

final class SettingsViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var settingsTableView: UITableView!

    // MARK: - Variables

    var settingsViewModel: SettingsViewModel!

    private let bag = DisposeBag()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }

    private func bindUI() {
        settingsViewModel.email
            .bind(to: usernameLabel.rx.text)
            .disposed(by: bag)

        settingsViewModel.settings
            .bind(to: settingsTableView.rx.items(cellIdentifier: "defaultSettingsCell", cellType: SettingsTableViewCell.self)) { _, setting, cell in
                cell.viewModel = SettingsCellViewModel(setting: setting)
            }
            .disposed(by: bag)

        settingsTableView.rx.itemSelected
            .bind { indexPath in
                self.settingsViewModel.selected(setting: indexPath.row)
                self.settingsTableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: bag)
    }
}
