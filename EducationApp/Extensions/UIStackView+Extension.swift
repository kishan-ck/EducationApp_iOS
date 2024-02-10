//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

//MARK: - UIStackView Setup
extension UIStackView {
    
    /// Remove all added subview from stackview
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        for v in removedSubviews {
            if v.superview != nil {
                NSLayoutConstraint.deactivate(v.constraints)
                v.removeFromSuperview()
            }
        }
    }
}
