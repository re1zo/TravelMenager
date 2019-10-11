import Foundation

struct Settings {

    static var googleMapsPlatformApiKey: String {
        let environment = settings?.object(forKey: current) as? NSDictionary
        return environment?.object(forKey: "googleMapsPlatformApiKey") as? String ?? ""
    }
    
    private static var settings: NSDictionary? {
        NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Settings", ofType: "plist")!)
    }
    
    private static var current: String {
        settings?.object(forKey: "current") as? String ?? ""
    }
}
