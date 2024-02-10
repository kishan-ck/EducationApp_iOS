//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIColor setup
extension UIColor {
    
    /// color with hax string
    ///
    /// - Parameter hexString: #000000
    convenience init(hexString:String) {
        var hexString:String = hexString.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if (hexString.hasPrefix("#")) { hexString.remove(at: hexString.startIndex) }
        
        var color:UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(displayP3Red: red, green: green, blue: blue, alpha: 1)
        //self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    /// Theme Yellow color : #E2A12D
    static let themeYellow = UIColor(hexString: "#E2A12D")
    
    /// Dark yellow color : #AF7100
    static let darkYellow = UIColor(hexString: "#AF7100")
    
    /// Theme gray color : #BEBEBE
    static let themeGray = UIColor(hexString: "#BEBEBE")
    
    /// Dark gray color : #7C7F86
    static let darkGrey = UIColor(hexString: "#7C7F86")
    
    /// Blue color : #0E3049
    static let blue = UIColor(hexString: "#0E3049")
    
    /// Navigation blue color : #131A2C
    static let navigationBlueColor = UIColor(hexString: "#131A2C")
    
    /// Placeholder color : #BABABA
    static let placeHolderColor = UIColor(hexString: "#BABABA")
    
    /// Title color : #252A36
    static let titleColor = UIColor(hexString: "#252A36")
    
    /// Dark Mode Tab bar color : #01152B
    static let tabbarDarkColor = UIColor(hexString: "#01152B")
    
    /// Text color : #F2F2F2
    static let textColor = UIColor(hexString: "#F2F2F2")
    
    /// Theme yellow float color : #E3A130
    static let themeYellowFloat = UIColor(hexString: "#E3A130")
    
    /// White Gradient Color : #D1D1D1
    static let whiteGradientColor = UIColor(hexString: "#D1D1D1")
    
    /// First White-Mode Gradient Color : #F3F4F6
    static let firstWhiteModeGradientColor = UIColor(hexString: "#F3F4F6")
    
    /// Second White-Mode Gradient Color : #D6D8DE
    static let secondWhiteModeGradientColor = UIColor(hexString: "#D6D8DE")
    
    /// White Mode Background Color : #FFFFFF
    static let whiteModeColor = UIColor(hexString: " #FFFFFF")
    
    /// Dark Mode Background Color : #000D1C
    static let darkModeColor = UIColor(hexString: " #000D1C")
    
    /// blackColor : #000000
    static let blackColor = UIColor(hexString: " #000000")
}
