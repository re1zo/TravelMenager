import UIKit

final class CoolColors {
    
    private static let all: [UIColor] = [
        #colorLiteral(red: 0.02352941176, green: 0.8392156863, blue: 0.6274509804, alpha: 1),
        #colorLiteral(red: 0.937254902, green: 0.2784313725, blue: 0.4352941176, alpha: 1),
        #colorLiteral(red: 0.4470588235, green: 0.5764705882, blue: 0.6274509804, alpha: 1),
        #colorLiteral(red: 0.9529381394, green: 0.5294414163, blue: 0.4705452919, alpha: 1),
        #colorLiteral(red: 0.2509543598, green: 0.2627937496, blue: 0.8195058703, alpha: 1),
        #colorLiteral(red: 0.20776847, green: 0.3608399034, blue: 0.9998764396, alpha: 1),
        #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
        #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),
        #colorLiteral(red: 0.02124723233, green: 0.8392589688, blue: 0.6273662448, alpha: 1),
        #colorLiteral(red: 0.9254609942, green: 0.69024086, blue: 0.882250011, alpha: 1),
        #colorLiteral(red: 0.956847012, green: 0.6235588193, blue: 0.03939998522, alpha: 1),
        #colorLiteral(red: 0.06198419631, green: 0.5882645845, blue: 0.2823077142, alpha: 1),
        #colorLiteral(red: 0.9490448833, green: 0.1058956757, blue: 0.2470684946, alpha: 1),
        #colorLiteral(red: 0.4273707271, green: 0.5568968654, blue: 0.6273716092, alpha: 1),
        #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),
    ]
    static var random: CGColor {
        (all.randomElement() ?? .yellow).cgColor
    }
}
