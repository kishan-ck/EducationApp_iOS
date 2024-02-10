//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

//MARK: - UIImage setup

extension UIImage {
    
    /// Fix orientation of UIImage.
    /// - Returns: return UIImage with fix orientation.
    func fixOrientation() -> UIImage {
        if (imageOrientation == .up) { return self }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
