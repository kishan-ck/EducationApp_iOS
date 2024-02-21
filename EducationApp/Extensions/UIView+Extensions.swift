//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

//MARK: - UIView setup
extension UIView {
    
    /// Bottom Round View for top left and top right corner radius.
    func bottomRoundView() {
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    /// roundCorner dynamically applies corner radius to view.
    @IBInspectable var roundCorner: Bool {
        get{
            if layer.cornerRadius == self.frame.size.width / 2
            {
                return true
            }
            return false
        }
        set {
            rounded()
        }
    }
    
    /// Applies corner radius to all four corners of view.
    func roundedHeightView() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
    /// View's identifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    /// For load uiview with XIB
    /// - Returns: return UIView from XIB
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    /// Returns the first constraint with the given identifier, if available.
    ///
    /// - Parameter identifier: "homeView"
    @objc func selfconstraintWithIdentifier(_ identifier: String) -> NSLayoutConstraint? {
        return self.constraints.first { $0.identifier == identifier }
    }
    
    
    /// To get the NSLayoutConstraint with particular identifier.
    /// - Parameter identifier: "homeView"
    /// - Returns: [NSLayoutConstraint]
    @objc func constraintWithIdentifier(_ identifier: String) -> NSLayoutConstraint? {
        var constraintsArray: [NSLayoutConstraint] = []
        var subviews: [UIView] = [self]
        while !subviews.isEmpty {
            constraintsArray += subviews.compactMap { $0.selfconstraintWithIdentifier(identifier) }
            subviews = subviews.flatMap { $0.subviews }
        }
        return constraintsArray.first
    }
    
    /// Used when popup view appers
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    /// Used when popup view disappears
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.isHidden = true
            self.alpha = 0.0
        }, completion: completion)
    }
    
    /// Function for converting subview's frame
    func getConvertedFrame(fromSubview subview: UIView) -> CGRect? {
        // check if `subview` is a subview of self
        guard subview.isDescendant(of: self) else {
            return nil
        }
        
        var frame = subview.frame
        if subview.superview == nil {
            return frame
        }
        
        var superview = subview.superview
        while superview != self {
            frame = superview!.convert(frame, to: superview!.superview)
            if superview!.superview == nil {
                break
            } else {
                superview = superview!.superview
            }
        }
        
        return superview!.convert(frame, to: self)
    }
    
    /// shadow for UIView
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
    
    /// shadow for UIView
    func rounded() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.layer.cornerRadius = self.frame.size.width / 2
            self.clipsToBounds = true
        }
    }
    
    /// roundCorner dynamically applies corner radius to view from @IBInspectable.
    @IBInspectable var cornerRadius: CGFloat {
        get{
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    /// roundCorner dynamically applies border width to view from @IBInspectable.
    @IBInspectable var borderWidth: Double {
          get {
            return Double(self.layer.borderWidth)
          }
          set {
           self.layer.borderWidth = CGFloat(newValue)
          }
    }
    
    /// roundCorner dynamically applies border color to view from @IBInspectable.
    @IBInspectable var borderColor: UIColor? {
         get {
            return UIColor(cgColor: self.layer.borderColor!)
         }
         set {
            self.layer.borderColor = newValue?.cgColor
         }
    }
    
    /// Applies shadow to UIView.
    /// - Parameters:
    ///   - cornerRadius: 10
    ///   - corners: []
    ///   - borderColor: UIColor.white
    ///   - borderWidth: 1
    ///   - shadowColor: UIColor.darkGrey
    func dropShadowed(cornerRadius:CGFloat, corners: UIRectCorner, borderColor: UIColor, borderWidth:CGFloat, shadowColor:UIColor) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        layer.mask?.shadowPath = path.cgPath
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
        layer.cornerRadius = cornerRadius
        
        if corners.contains(.topLeft) || corners.contains(.topRight) {
            layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        }
        if corners.contains(.bottomLeft) || corners.contains(.bottomRight) {
            layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        }
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.shadowPath =  nil//path.cgPath
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    /// provide parent view controller of given view return first view controller from views
    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
    
    /// Completion handler for call back
    typealias CompletionHandler = () -> Void
    
    /// Show Toast Message at bottom
    /// - Parameters:
    ///   - message: pass message string
    ///   - font: pass Font for the message
    func showToast(message : String, font: UIFont, completionHandler: CompletionHandler? = nil) {
        let toastLabel = PaddingLabel()
        toastLabel.topInset = 8
        toastLabel.bottomInset = 8
        toastLabel.leftInset = 8
        toastLabel.rightInset = 8
        toastLabel.textColor = UIColor(named: "#FFFFFF")
        toastLabel.numberOfLines = 1
        toastLabel.backgroundColor = UIColor(named: "#000000")
        toastLabel.textAlignment = .center
        toastLabel.font = font
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds =  true
        
        KAPPDELEGATE.window?.addSubview(toastLabel)
        
        let fontAttributes = [NSAttributedString.Key.font: font]
        let text = message
        let size = (text as NSString).size(withAttributes: fontAttributes)
        toastLabel.frame = CGRect(x: 0, y: 0, width: size.width + 16, height: size.height + 16)
        toastLabel.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 50)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            if let completionHandler = completionHandler {
                completionHandler()
            }
        })
    }
}

extension UIView {
    
    /// Recursive find subviews
    ///
    /// - Parameter name: UIView 的类名称
    /// - Returns: 找到的 UIView
    func recursiveFindSubview(of name: String) -> UIView? {
        for view in subviews {
            if view.isKind(of: NSClassFromString(name)!) {
                return view
            }
        }
        for view in subviews {
            if let tempView = view.recursiveFindSubview(of: name) {
                return tempView
            }
        }
        return nil
    }
}
