import Foundation

final class Localization {

    static let `default` = Localization()
    private let translations = NSDictionary(contentsOf: Bundle.main.url(forResource: "Localization", withExtension: "plist")!)

    func string(forPath path: String) -> String? {
        translations?.value(forKeyPath: path) as? String ?? translations?.value(forKeyPath: "\(path).value") as? String
    }
}
