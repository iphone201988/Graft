import UIKit

@IBDesignable
class OpenSansLbl: UILabel {
    
    @IBInspectable var openSansStyleIndex: Int = 0 {
        didSet {
            updateFont()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateFont()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateFont()
    }
    
    private func updateFont() {
        
        let styles: [Int: String] = [
            0: "Regular",
            1: "Medium",
            2: "SemiBold",
            3: "Bold",
            4: "ExtraBold",
            5: "Light",
            6: "Italic"
        ]
        
        let selectedStyle = styles[openSansStyleIndex] ?? "Regular"
        let fontName = "OpenSans-\(selectedStyle)"
        
        if let customFont = UIFont(name: fontName, size: self.font.pointSize) {
            self.font = customFont
        } else {
            print("⚠️ Font '\(fontName)' not found. Check bundle & Info.plist")
        }
    }
}

@IBDesignable
class OpenSansTF: UITextField {
    
    @IBInspectable var openSansStyleIndex: Int = 0 {
        didSet {
            updateFont()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateFont()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateFont()
    }
    
    private func updateFont() {
        
        let styles: [Int: String] = [
            0: "Regular",
            1: "Medium",
            2: "SemiBold",
            3: "Bold",
            4: "ExtraBold",
            5: "Light",
            6: "Italic"
        ]
        
        let selectedStyle = styles[openSansStyleIndex] ?? "Regular"
        let fontName = "OpenSans-\(selectedStyle)"
        
        if let customFont = UIFont(name: fontName, size: self.font?.pointSize ?? 12.0) {
            self.font = customFont
        } else {
            print("⚠️ Font '\(fontName)' not found. Check bundle & Info.plist")
        }
    }
}

@IBDesignable
class OpenSansTV: UITextView {
    
    @IBInspectable var openSansStyleIndex: Int = 0 {
        didSet {
            updateFont()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateFont()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateFont()
    }
    
    private func updateFont() {
        
        let styles: [Int: String] = [
            0: "Regular",
            1: "Medium",
            2: "SemiBold",
            3: "Bold",
            4: "ExtraBold",
            5: "Light",
            6: "Italic"
        ]
        
        let selectedStyle = styles[openSansStyleIndex] ?? "Regular"
        let fontName = "OpenSans-\(selectedStyle)"
        
        if let customFont = UIFont(name: fontName, size: self.font?.pointSize ?? 12.0) {
            self.font = customFont
        } else {
            print("⚠️ Font '\(fontName)' not found. Check bundle & Info.plist")
        }
    }
}
