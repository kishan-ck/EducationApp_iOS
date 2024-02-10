//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation
import UIKit

//MARK: - UITextField Setup
/// Textfield Alignment set with language
/// UITextField Alighment set with language
extension UITextField {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.autocorrectionType = .no
        
        if getLangCode() == arabic {
            if self.textAlignment == .center {
                self.textAlignment = .center
            }
            else {
                self.textAlignment = .right
            }
        } else {
            if self.textAlignment == .center {
                self.textAlignment = .center
            }
            else {
                self.textAlignment = .left
            }
        }
    }
    
    
    /// Applies color to UITextField Placeholder.
    @IBInspectable var placeholderColor: UIColor {
        get {
            return attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .clear
        }
        set {
            guard let attributedPlaceholder = attributedPlaceholder else { return }
            let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: newValue]
            self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
        }
    }
    
    /// Use this method while you need text from text field as there never crash and get "" alwasys string
    ///
    /// - Returns: return string
    @objc func getText()-> String {
        if (self.text?.count)! > 0{
            return self.text!
        }else{
            return ""
        }
    }
    
    
    /// set padding to the left side of UITextField
    /// - Parameter amount: 14
    func setLeftPaddingPoints(_ amount:CGFloat){
        self.leftViewMode = .always
        let paddingView = UIControl(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        paddingView.addTarget(self, action: #selector(touchDown), for: [.touchUpInside])
        self.leftView = paddingView
    }
    
    /// Asks UIKit to make this object the first responder in its window.
    @objc
    private func touchDown() {
        self.becomeFirstResponder()
    }
    
    /// set padding to the right side of UITextField
    /// - Parameter amount: 14
    func setRightPaddingPoints(_ amount:CGFloat) {
        self.rightViewMode = .always
        let paddingView = UIControl(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        paddingView.addTarget(self, action: #selector(touchDown), for: [ .touchUpInside])
        self.rightView = paddingView
    }
    
    
    /// set maximum allowed legth of string in UITextField.
    @IBInspectable var maxLength: Int {
        get {
            guard let l = maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    /// set a touch making an editing change in a UITextField object.
    /// - Parameter textField: UITextField
    @objc func fix(textField: UITextField) {
        if let t: String = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
    
    /// Font style for all UITextField
    @IBInspectable var style: String {
        set {
            self.font = UIFont(name: (allFont [newValue]?["name"] ?? "Manrope-Regular"), size: self.font?.pointSize ?? 0.0)
        }
        get {
            return ""
        }
    }
}
