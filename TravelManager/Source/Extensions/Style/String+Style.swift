import UIKit

extension String {

    var randomColor: CGColor {
        let hash = abs(hashValue)
        let colorNum = hash % (256 * 256 * 256)
        let red = colorNum >> 16
        let green = (colorNum & 0x00FF00) >> 8
        let blue = (colorNum & 0x0000FF)
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0).cgColor
    }
}
