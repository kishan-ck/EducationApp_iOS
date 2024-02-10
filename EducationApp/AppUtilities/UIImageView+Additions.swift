//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

/// Dynamically applies rounded corner to UIImageView.
class DynamicCornerRadiusImageView: UIImageView {
    
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
