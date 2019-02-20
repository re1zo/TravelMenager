import Foundation

struct Settings {

    static var googleMapsApiKey: String {
        let environment = settings.object(forKey: current) as! NSDictionary
        return environment.object(forKey: "googleMapsApiKey") as! String
    }
    
    private static var settings: NSDictionary {
        let path = Bundle.main.path(forResource: "Settings", ofType: "plist")!
        return NSDictionary(contentsOfFile: path)!
    }
    
    private static var current: String {
        return settings.object(forKey: "current") as! String
    }
}
