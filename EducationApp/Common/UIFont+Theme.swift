//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation
import UIKit

/// setup fonts with diffrent font families and styles.
enum themeFonts : String {
    case poppinsRegular = "Poppins-Regular"
    case poppinsBold = "Poppins-Bold"
}

/// Setting up themeFont through all over the app
/// - Parameters:
///   - size: font size
///   - fontname: font name
/// - Returns: returns UIFont
/// 350, 375, 390, 414, 428, 430
func themeFont(size : Float, fontname : themeFonts) -> UIFont {
    if UIScreen.main.bounds.width <= 320 {
        return UIFont(name: fontname.rawValue, size: CGFloat(size) - 3.0) ?? UIFont(name: themeFonts.poppinsRegular.rawValue, size: CGFloat(size) - 3.0)!
    } else if UIScreen.main.bounds.width == 350 {
        return UIFont(name: fontname.rawValue, size: CGFloat(size) - 2.0) ?? UIFont(name: themeFonts.poppinsRegular.rawValue, size: CGFloat(size) - 2.0)!
    } else if UIScreen.main.bounds.width == 375 {
        return UIFont(name: fontname.rawValue, size: CGFloat(size) - 1.0) ?? UIFont(name: themeFonts.poppinsRegular.rawValue, size: CGFloat(size) - 1.0)!
    } else if UIScreen.main.bounds.width == 390 {
        return UIFont(name: fontname.rawValue, size: CGFloat(size) - 1.0) ?? UIFont(name: themeFonts.poppinsRegular.rawValue, size: CGFloat(size) - 1.0)!
    } else {
        return UIFont(name: fontname.rawValue, size: CGFloat(size)) ?? UIFont(name: themeFonts.poppinsRegular.rawValue, size: CGFloat(size))!
    }
}
