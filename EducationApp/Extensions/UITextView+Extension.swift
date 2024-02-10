//
// Copyright (c) 2024 Education App All rights reserved.
//

import Foundation
import UIKit

//MARK: - UITextView Setup
/// UITextView Alighment set with language
/// UITextView Alighment set with language
extension UITextView {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        if getLangCode() == arabic {
            if self.textAlignment == .center {
                self.textAlignment = .center
            } else {
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
    
    /// Font style for all UITextView
    @IBInspectable var style: String {
        set {
            self.font = UIFont(name: (allFont [newValue]?["name"] ?? "Manrope-Regular"), size: self.font?.pointSize ?? 0.0)
        }
        get {
            return ""
        }
    }
}
