//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit

///Theme Yellow UIButton with gradient.
class themeButton : UIButton {
    
    override func awakeFromNib() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor(named: "ThemeYellow - #E2A12D")!.cgColor, UIColor(named: "DarkYellow - #AF7100")!.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            self.layer.cornerRadius = self.bounds.height / 2
            self.clipsToBounds = true
        }
    }
}

/// Dynamically applies rounded corner to UIButton.
class DynamicCornerRadiusButton : UIButton {
    
    override func awakeFromNib() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.layer.cornerRadius = self.bounds.height / 2
            self.clipsToBounds = true
        }
    }
}
