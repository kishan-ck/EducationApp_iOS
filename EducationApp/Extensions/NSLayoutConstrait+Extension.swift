//
// Copyright (c) 2024 Education App All rights reserved.
//

import Foundation
import UIKit

//MARK: - NSLayoutConstraint setup
extension NSLayoutConstraint {
    
    /// To set constatnt by screen width %
    @IBInspectable var widthPercentage: Double {
        get {
            return self.constant
        }
        
        set {
            self.constant = UIScreen.main.bounds.width * newValue / 100
        }
    }
    
    /// To set constatnt by screen width %
    @IBInspectable var heightPercentage: Double {
        get {
            return self.constant
        }
        
        set {
            self.constant = UIScreen.main.bounds.height * newValue / 100
        }
    }
}
