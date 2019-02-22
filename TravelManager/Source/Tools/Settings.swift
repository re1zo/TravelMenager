import Foundation

struct Settings {

    static var googleMapsApiKey: String {
        let environment = settings?.object(forKey: current) as? NSDictionary
        return environment?.object(forKey: "googleMapsApiKey") as? String ?? ""
    }
    
    private static var settings: NSDictionary? {
        return NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Settings", ofType: "plist")!)
    }
    
    private static var current: String {
        return settings?.object(forKey: "current") as? String ?? ""
    }
}
