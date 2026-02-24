import UIKit

@IBDesignable
class CustomView: UIView {}

extension UIView {
    
    private struct AssociatedKey {
        static var rounded = "UIView.rounded"
    }
    
    @IBInspectable var rounded: Bool {
        get {
            if let rounded = objc_getAssociatedObject(self, &AssociatedKey.rounded) as? Bool {
                return rounded
            } else {
                return false
            }
        }
        set {
            DispatchQueue.main.async {
                objc_setAssociatedObject(self, &AssociatedKey.rounded, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                self.layer.cornerRadius = CGFloat(newValue ? 1.0 : 0.0)*min(self.bounds.width,
                                                                            self.bounds.height)/2
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get { return UIColor.init(cgColor: layer.shadowColor!) }
        set { layer.shadowColor = newValue.cgColor }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
    @IBInspectable var maskToBounds: Bool {
        get { return layer.masksToBounds }
        set { layer.masksToBounds = newValue }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    func setViewCircle() {
        self.layer.cornerRadius = self.bounds.size.height / 2.0
        self.clipsToBounds = true
    }
    
    func getElements<T: UIView>(ofType type: T.Type) -> [T] {
        var elements = [T]()
        for subview in self.subviews {
            if let element = subview as? T {
                elements.append(element)
            }
            elements.append(contentsOf: subview.getElements(ofType: type)) // Recursive call
        }
        return elements
    }
}

import UIKit

private var localizationKeyAssociationKey: UInt8 = 0

extension UIView {
    
    @IBInspectable var localizationKey: String? {
        get {
            return objc_getAssociatedObject(self, &localizationKeyAssociationKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &localizationKeyAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            applyLocalization()
        }
    }
    
    func applyLocalization() {
        guard let key = localizationKey else { return }
        let text = key.localized() // using your localization helper
        
        switch self {
        case let label as UILabel:
            label.text = text
            
        case let button as UIButton:
            button.setTitle(text, for: .normal)
            
        case let textField as UITextField:
            textField.placeholder = text
            
        case let textView as UITextView:
            textView.text = text
            
        default:
            break
        }
    }
    
    func applyGradientBorder(width: CGFloat, cornerRadius: CGFloat = 0) {
        // Remove existing gradient borders (important on layout updates)
        layer.sublayers?
            .filter { $0.name == "GradientBorderLayer" }
            .forEach { $0.removeFromSuperlayer() }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "GradientBorderLayer"
        gradientLayer.colors = [
            UIColor(red: 66/255, green: 0/255, blue: 64/255, alpha: 1).cgColor,
            UIColor(red: 17/255, green: 0/255, blue: 89/255, alpha: 1).cgColor,
        ]
        
        // ⭐ Left → Right
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint   = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = bounds
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
        shapeLayer.path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        gradientLayer.mask = shapeLayer
        layer.addSublayer(gradientLayer)
    }
}

extension UIView {
    
    func applyAnimatedGradientBorder(colors: [UIColor], lineWidth: CGFloat = 4.0, cornerRadius: CGFloat = 12.0) {
        
        layer.sublayers?.removeAll(where: { $0.name == "animatedGradientBorder" })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "animatedGradientBorder"

        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        gradientLayer.locations = [0.0, 0.25, 0.5, 0.75, 1.0].map { NSNumber(value: $0) }
        
        let shape = CAShapeLayer()
        
        shape.path = UIBezierPath(
            roundedRect: bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2),
            cornerRadius: cornerRadius
        ).cgPath
        
        //        shape.path = UIBezierPath(
        //            roundedRect: bounds,  // Use same bounds
        //            cornerRadius: cornerRadius
        //        ).cgPath
        shape.frame = bounds
        
        shape.lineWidth = lineWidth
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineCap = .round
        
        gradientLayer.mask = shape
        
        let animationDuration: CFTimeInterval = 4.0
        
        let startPointValues: [CGPoint] = [
            CGPoint(x: 0, y: 0),
            CGPoint(x: 1, y: 0),
            CGPoint(x: 1, y: 1),
            CGPoint(x: 0, y: 1),
            CGPoint(x: 0, y: 0)
        ]
        
        let endPointValues: [CGPoint] = [
            CGPoint(x: 1, y: 0),
            CGPoint(x: 1, y: 1),
            CGPoint(x: 0, y: 1),
            CGPoint(x: 0, y: 0),
            CGPoint(x: 1, y: 0)
        ]
        
        let startPointAnimation = CAKeyframeAnimation(keyPath: "startPoint")
        startPointAnimation.values = startPointValues
        startPointAnimation.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0].map { NSNumber(value: $0) }
        startPointAnimation.duration = animationDuration
        startPointAnimation.repeatCount = .infinity
        startPointAnimation.calculationMode = .linear
        
        let endPointAnimation = CAKeyframeAnimation(keyPath: "endPoint")
        endPointAnimation.values = endPointValues
        endPointAnimation.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0].map { NSNumber(value: $0) }
        endPointAnimation.duration = animationDuration
        endPointAnimation.repeatCount = .infinity
        endPointAnimation.calculationMode = .linear
        
        gradientLayer.add(startPointAnimation, forKey: "shimmerStartPoint")
        gradientLayer.add(endPointAnimation, forKey: "shimmerEndPoint")
        
        layer.addSublayer(gradientLayer)
    }
}
