//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit

/// Dynamically applies rounded corner to UIView.
class DynamicCornerRadiusView : UIView {
    
    /// awake From Nib
    ///
    /// - Purpose : Called when nib loads.
    /// - Description : To set values after view awakes.
    override func awakeFromNib() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.layer.cornerRadius = self.bounds.height / 2
            self.clipsToBounds = true
        }
    }
}

/// Applies Static blue and black color gradient class to StaticBlueGradientView and used as static gradient class for both dark and light mode.
class StaticBlueGradientView : UIView {
    
    /// To used for gradient layer object
    var gradient = CAGradientLayer()
    
    /// awake From Nib
    ///
    /// - Purpose : Called when nib loads.
    /// - Description : To set values after view awakes.
    override func awakeFromNib() {
        setupGradientView()
    }
    
    /// To used for layout subviews for update the frame
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
    }
    
    /// To set up gradient view for the layer
    func setupGradientView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.gradient.colors = [UIColor(named: "Blue - #0E3049")!.cgColor, UIColor.black.cgColor]
            self.gradient.startPoint = CGPoint(x: 1, y: 0)
            self.gradient.endPoint = CGPoint(x: 0, y: 1)
            self.layer.insertSublayer(self.gradient, at: 0)
        }
    }
}

/// Applies blue and black color gradient class to UIView in both dark and light mode.
class BlueGradientView : UIView {
    
    /// To used for gradient layer object
    var gradient = CAGradientLayer()
    
    /// awake From Nib
    ///
    /// - Purpose : Called when nib loads.
    /// - Description : To set values after view awakes.
    override func awakeFromNib() {
        setupGradientView()
    }
    
    /// To used for layout subviews for update the frame
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
    }
    
    /// To set up gradient view for the layer
    func setupGradientView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.gradient.colors = [UIColor(named: "FirstViewGradientColor")?.cgColor ?? "", UIColor(named: "SecondViewGradientColor")?.cgColor ?? ""]
            self.gradient.startPoint = CGPoint(x: 1, y: 0)
            self.gradient.endPoint = CGPoint(x: 0, y: 1)
            
            self.layer.insertSublayer(self.gradient, at: 0)
        }
    }
}

/// Applies blue and black color gradient class to backViews in reversed manner than BlueGradientView.
class ReverseGradientView : UIView {
    
    /// awake From Nib
    ///
    /// - Purpose : Called when nib loads.
    /// - Description : To set values after view awakes.
    override func awakeFromNib() {
        setupGradientView()
    }
    
    /// To set up gradient view for the layer
    func setupGradientView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            
            let gradient = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = [UIColor(named: "SecondBackViewGradientColor")?.cgColor ?? "", UIColor(named: "FirstBackViewGradientColor")?.cgColor ?? ""]
            gradient.startPoint = CGPoint(x: 1, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
            
            self.layer.insertSublayer(gradient, at: 0)
        }
    }
}

/// Applies blue and black color gradient class to backViews.
class BlueGradientViewForBackView : UIView {
    
    /// To used for gradient layer object
    var gradient = CAGradientLayer()
    
    /// awake From Nib
    ///
    /// - Purpose : Called when nib loads.
    /// - Description : To set values after view awakes.
    override func awakeFromNib() {
        setupGradientView()
    }
    
    /// To used for layout subviews for update the frame
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
    }
    
    /// To set up gradient view for the layer
    func setupGradientView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            
            self.gradient.frame = self.bounds
            self.gradient.colors = [UIColor(named: "FirstBackViewGradientColor")?.cgColor ?? "", UIColor(named: "SecondBackViewGradientColor")?.cgColor ?? ""]
            self.gradient.startPoint = CGPoint(x: 1, y: 0)
            self.gradient.endPoint = CGPoint(x: 0, y: 1)
            
            self.layer.insertSublayer(self.gradient, at: 0)
        }
    }
}

///for UIView with dashed border style
class DashedView: UIView {
    
    @IBInspectable var cornerRadiuss: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0
    
    var dashBorder: CAShapeLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
