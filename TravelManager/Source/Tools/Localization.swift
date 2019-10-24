import Foundation

final class Localization {

    static let `default` = Localization()
    private let translations = NSDictionary(contentsOf: Bundle.main.url(forResource: "Localization", withExtension: "plist")!)

    func string(forPath path: String) -> String? {
        translations?.value(forKey: path) as? String ?? translations?.value(forKey: "\(path).value") as? String
    }
}
