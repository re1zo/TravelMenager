import UIKit
import Firebase

final class SettingsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var usernameLabel: UILabel!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = AppUser().current?.email ?? ""
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "defaultSettingsCell")
    }
}

// MARK: - UITableViewDelegate && UITableViewDataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "defaultSettingsCell") as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = SettingsItem.allCases[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        switch SettingsItem.allCases[indexPath.row] {
        case .logout:
            try? Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
    }

}
