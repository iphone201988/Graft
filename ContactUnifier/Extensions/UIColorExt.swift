import UIKit

extension UIColor {
    
//    convenience init(hex: String) {
//        let scanner = Scanner(string: hex)
//        scanner.scanLocation = 1
//        var rgb: UInt64 = 0
//        scanner.scanHexInt64(&rgb)
//        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
//        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
//        let b = CGFloat(rgb & 0xFF) / 255.0
//        self.init(red: r, green: g, blue: b, alpha: 1.0)
//    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
