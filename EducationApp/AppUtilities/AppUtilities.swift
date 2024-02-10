//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class AppUtilities: NSObject {
    
    /// To used for convert date format
    ///
    /// - Parameters:
    ///   - fromFormat: passing from format
    ///   - toFormat: passing to format
    ///   - dateString: passing date string
    /// - Returns: return string value
    class func convertDateFormat(fromFormat: String, toFormat: String, dateString: String) -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = fromFormat
        let oldDate = olDateFormatter.date(from: dateString)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = toFormat
        return convertDateFormatter.string(from: oldDate ?? Date())
    }

    
    /// Only 1-9 Number are allowed.
    /// - Parameter str: Passing String
    /// - Returns: return 1-9 numbers
    func isAllowed(str: String?) -> Bool {
        let regexPattern: String = "^((?!(0))[0-9]{0,10})$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regexPattern)
        return predicate.evaluate(with: str)
    }

    /// Regex for only Number space are allowed
    func onlyNumberSpaceAllowed(string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: #"^[0-9 ]*$"#, options: .anchorsMatchLines)
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                return false
            }
        }
        catch {
            print("Invalid charecter enter.")
        }
        return true
    }

    /// Regex for only Charecter space are allowed
    func onlyCharacterAllowed(string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z].* ", options: [])
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                return false
            }
        } catch {
            print("Invalid charecter enter.")
        }
        return true
    }

    /// Regex to prevent of entering speacial characters
    func specialCharacterNotAllowed(string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "'*=+[]\\|;:'\",<>/?%", options: [])
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                return false
            }
        } catch {
            print("Invalid charecter enter.")
            return false
        }
        return true
    }

    /// Regex for only Charecter Number space are allowed
    func allowCharacterNumberSpacing(txt: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9 ].*", options: [])
            if regex.firstMatch(in: txt, options: [], range: NSMakeRange(0, txt.count)) != nil {
                return false
            }
        } catch {
            print("Not allow character.")
        }
        return true
    }

    /// Hex to UIColor
    /// - Returns: pass #aaaaa hex colorcode return uicolor
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /// To used for append dot after string
    ///
    /// - Parameter str: passing string value.
    /// - Returns: return string value.
    class func appendDotAfterString(str : String, capitalize: Bool? = true) -> String{
        var stringData : String = ""
        if(str.contains(".")){
            if(str.trim() != ""){
                let data_str = ((str.trim().last) == ".")
                if(data_str == true){
                    stringData = str
                }else{
                    stringData = NSString(format: "%@.", str) as String
                }
            }else{
                stringData = str
            }
        }else if(str.contains("?")){
            if(capitalize ?? false){
                return str.trim().capitalizingFirstLetter()
            }else{
                return str.trim()
            }
        }else{
            stringData = NSString(format: "%@.", str) as String
        }
        if(capitalize ?? false){
            return stringData.trim().capitalizingFirstLetter()
        }else{
            return stringData.trim()
        }
    }
    
    /// To generate unique name
    class func uniqueFileName() -> String {
        let uniqueString = UUID().uuidString
        return uniqueString
    }
    
    /// Get uilable height for view.
    ///
    /// - Parameters:
    ///   - text: passing text string.
    ///   - font: passing font.
    ///   - width: passing width.
    /// - Returns: return lable frame height.
    class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width:width,height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    /// To use this function for preload video
    /// - Parameter html: passing html string
    /// - Returns: return string
    class func preloadVideoContent(html: String) -> String{
        var replaceHtml: String = ""
        replaceHtml = html.replacingOccurrences(of: ".mp4".lowercased(), with: ".mp4#t=0.001").replacingOccurrences(of: ".mov".lowercased(), with: ".mov#t=0.001").replacingOccurrences(of: ".wmv".lowercased(), with: ".wmv#t=0.001")
        return replaceHtml
    }
}
