//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation
import EasyTipView

/// DismissibleEasyTipView class is a dismissable version of EasyTipView class.
class DismissibleEasyTipView: EasyTipView {
    
    /// UITapGestureRecognizer for dismissView.
    lazy var tapRecognizer: UITapGestureRecognizer = {
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnScreen))
        tapRecognizer.numberOfTapsRequired = 1
        
        return tapRecognizer
    }()
    
    /// Background view used as a dismiss view for tip view.
    lazy var dismissView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = .clear
        view.frame = UIScreen.main.bounds
        
        return view
    }()
    
    
    /// used to display Tip view.
    /// - Parameter view: UIView on which tip view will be displayed.
    func show(on view: UIView) {
        
        self.show(forView: view)
        
        guard let superView = self.superview else { return }
        
        self.addDismissView(on: superView)
    }
    
    /// Creates a view by which tip view will be dismissed.
    /// - Parameter superView: view by which tip view will be dismissed
    private func addDismissView(on superView: UIView) {
        
        if self.dismissView.superview == nil {
            superView.addSubview(self.dismissView)
        }
        
        if !(self.dismissView.gestureRecognizers ?? []).contains(self.tapRecognizer) {
            self.dismissView.addGestureRecognizer(self.tapRecognizer)
        }
        
        self.tapRecognizer.isEnabled = true
    }
    
    /// Used to hide tip view.
    func hide() {
        
        self.dismissView.removeFromSuperview()
        self.tapRecognizer.isEnabled = false
        self.dismiss()
    }
    
    /// Click Event for dismissing tip view.
    @objc func didTapOnScreen() {
        self.hide()
    }
}
