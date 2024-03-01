//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

/// Dynamically applies rounded corner to UIButton.
class DynamicCornerRadiusButton : UIButton {
    
    override func awakeFromNib() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.layer.cornerRadius = self.bounds.height / 2
            self.clipsToBounds = true
        }
    }
}
