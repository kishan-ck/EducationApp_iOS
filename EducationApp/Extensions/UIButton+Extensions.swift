//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

//MARK: - UIButton Setup
extension UIButton {

    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setTitle(self.currentTitle?.localized, for: .normal)
    }
    
    /// Font style for all UIButton
    @IBInspectable var style: String {
        set {
            self.titleLabel?.font = UIFont(name: (allFont [newValue]?["name"] ?? themeFonts.poppinsRegular.rawValue), size: self.titleLabel?.font.pointSize ?? 0.0)
        }
        get {
            return ""
        }
    }
}
