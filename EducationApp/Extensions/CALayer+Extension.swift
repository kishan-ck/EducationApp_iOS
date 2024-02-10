//
// Copyright (c) 2024 Education App All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

//MARK: - CALayer setup
extension CALayer {
    
    /// Applies Shadow to UIKit.
    /// - Parameters:
    ///   - color: Shadow Color
    ///   - alpha: Shadow Opacity
    ///   - x: X postiion of Shadow
    ///   - y: Y postiion of Shadow
    ///   - blur: Blur ratio of Shadow
    ///   - spread: Spread of shadow
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0)
  {
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
