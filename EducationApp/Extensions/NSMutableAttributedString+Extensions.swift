//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation
import UIKit

//MARK: - NSMutableAttributedString setup
extension NSMutableAttributedString {
    
    /// for setup bold fonts
    var boldFont : UIFont { return themeFont(size: 14, fontname: .poppinsBold) }
    
    /// for setup normal fonts
    var normalFont : UIFont { return themeFont(size: 14, fontname: .poppinsRegular)}
    
    
    /// setup bold fonts to attributed string.
    /// - Parameter value: set bold font to selected string from attributed string
    /// - Returns: returns NSMutableAttributedString
    func bold(_ value:String) -> NSMutableAttributedString {
        let attributes : [NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    /// setup normal fonts to attributed string.
    /// - Parameter value: set normal font to selected string from attributed string
    /// - Returns: returns NSMutableAttributedString
    func normal(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    /// setup orange color highlight to selected attributed string.
    /// - Parameter value: set orange color highlight to selected string from attributed string
    /// - Returns: returns NSMutableAttributedString
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    /// setup black color highlight to selected attributed string.
    /// - Parameter value: set black color highlight to selected string from attributed string
    /// - Returns: returns NSMutableAttributedString
    func blackHighlight(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    /// setup underlined text to selected attributed string.
    /// - Parameter value: set underlined text to selected string from attributed string
    /// - Returns: returns NSMutableAttributedString
    func underlined(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    /// setup particular text color to selected attributed string.
    /// - Parameter value: set particular text color to selected string from attributed string
    /// - Returns: returns NSMutableAttributedString
    func setColorForText(_ textToFind: String, with color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }
}
