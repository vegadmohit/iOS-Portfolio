import UIKit

@IBDesignable
extension UIView {

    // Corner Radius
    @IBInspectable var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.cornerCurve = .continuous // smooth Apple-style corners
        }
    }

    // Shadow Color
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let cgColor = layer.shadowColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { layer.shadowColor = newValue?.cgColor }
    }
    
    // MARK: - Border
       @IBInspectable var borderWidth: CGFloat {
           get { layer.borderWidth }
           set { layer.borderWidth = newValue }
       }

       @IBInspectable var borderColor: UIColor? {
           get {
               guard let cgColor = layer.borderColor else { return nil }
               return UIColor(cgColor: cgColor)
           }
           set { layer.borderColor = newValue?.cgColor }
       }

    // Shadow Opacity
    @IBInspectable var shadowOpacity: Float {
        get { layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }

    // Shadow Offset
    @IBInspectable var shadowOffset: CGSize {
        get { layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    // Shadow Radius
    @IBInspectable var shadowRadius: CGFloat {
        get { layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }

}
