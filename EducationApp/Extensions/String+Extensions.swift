//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import MobileCoreServices

//MARK: -String Setup
extension String {
    
    /// HTML to String
    /// - Returns: Returns HTML data into String  format
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: true) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
    
    /// Name Validation
    var isValidName: Bool {
        let regularExpressionForName = "^(?! +$)[A-Za-zăâîșțĂÂÎȘȚ -]+$"
        let testName = NSPredicate(format:"SELF MATCHES %@", regularExpressionForName)
        return testName.evaluate(with: self)
    }
    
    /// Validate String with only numbers
    var isOnlyNumber: Bool {
        let regularExpressionForName = "[1-0]"
        let testName = NSPredicate(format:"SELF MATCHES %@", regularExpressionForName)
        return testName.evaluate(with: self)
    }
    
    /// Validate String with only characters
    var isOnlyCharacter: Bool {
        let regularExpressionForName = "[a-zA-Z]"
        let testName = NSPredicate(format:"SELF MATCHES %@", regularExpressionForName)
        return testName.evaluate(with: self)
    }
    
    /// Phone Number Validation
    public var validPhoneNumber : Bool {
        let types:NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
        
        if let match = detector.matches(in: self, options: [], range: NSMakeRange(0,self.count)).first?.phoneNumber {
            return match == self
        } else {
            return false
        }
    }
    
    /// give two decimal point value
    func setDecimalPoint(minimumFractionDigits : Int?, maximumFractionDigits : Int?) -> String {
        let numberFormatter:NumberFormatter = NumberFormatter.init()
        numberFormatter.decimalSeparator = "."
        numberFormatter.maximumFractionDigits = maximumFractionDigits ?? 0
        numberFormatter.minimumFractionDigits = minimumFractionDigits ?? 0
        //numberFormatter.minimumIntegerDigits = 1
        return  numberFormatter.string(from: NSNumber.init(value: getDouble(value: self)))!
    }
    
    /// Trims whitespaces from String and provides new string.
    /// - Parameter characterSet: Returns a character set containing characters in Unicode General Category Z*, U+000A ~ U+000D, and U+0085.
    /// - Returns: Returns a new string made by removing from both ends of the String characters contained in a given character set.
    func trim(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return trimmingCharacters(in: characterSet)
    }
    
    /// Converts to JSON
    /// - Returns: JSON
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}

/// To used for string extension
extension String {
    
    /// To used for capitalizing first letter
    ///
    /// - Returns: return string value
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    /// To used for mutating keyword for the string
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

/// To used for find height of label
extension String {
    
    /// To used for find height
    /// - Parameters:
    ///   - width: passing width value.
    ///   - font: passing font value.
    /// - Returns: return float value.
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }

    /// To used for find width
    /// - Parameters:
    ///   - width: passing height value.
    ///   - font: passing font value.
    /// - Returns: return float value.
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

extension String {
    
    /// To used for utf data
    var utfData: Data {
        return Data(utf8)
    }
    
    /// To attributed html string data
    var attributedHtmlString: NSAttributedString? {
        do {
            return try NSAttributedString(data: utfData, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
        } catch {
            //print("Error:", error)
            return nil
        }
    }
    
    /// To post attributed string data
    var postAtributedString: NSAttributedString? {
        var parsedCommentHTML = self.replacingOccurrences(of: "<blockquote>\n", with: "<blockquote>\n<k style=\"color:#3e4a5a; font-size: 2em; font-family: 'Copperplate'\">“</k>")
        let blockQuoteCSS = "\nblockquote > p {color:#808080; display: inline;} \n blockquote { background: #dddfef;}"
        let pCSS = "p {margin-bottom: 0px;}"
        let cssStyle = "\(blockQuoteCSS)\n\(pCSS)\n"
        parsedCommentHTML = parsedCommentHTML.replace("http://", withString: "https://")
        do {
            return try NSAttributedString(data: ("<html><head><style>\(cssStyle)</style></head><span style=\"font-family: HelveticaNeue-Thin; font-size: 15\">\(parsedCommentHTML)</span></html>").data(using: String.Encoding.unicode)!, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
        } catch {
            //print("Error:", error)
            return nil
        }
    }
}

extension String {
    
    /// replace text in string
    ///
    /// - Parameters:
    ///   - string: orignal string
    ///   - withString: replace string
    /// - Returns: give final string
    mutating func replace(_ string: String, withString: String) -> String {
        return self.replacingOccurrences(of: string, with: withString)
    }
    
    /// give string witdh
    ///
    /// - Parameters:
    ///   - textHeight: give height what you need in width
    ///   - textFont: pass font
    /// - Returns: return width as per height and font
    func textWidth(_ textHeight: CGFloat, textFont: UIFont) -> CGFloat {
        let textRect: CGRect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: textHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil)
        let textSize: CGSize = textRect.size
        return ceil(textSize.width)
    }
    
    /// give string height as per width and font
    ///
    /// - Parameters:
    ///   - textWidth: pass fix width
    ///   - textFont: pass font
    /// - Returns: retun height as per width and font
    func textHeight(_ textWidth: CGFloat, textFont: UIFont) -> CGFloat {
        let textRect: CGRect = self.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil)
        let textSize: CGSize = textRect.size
        return ceil(textSize.height)
    }
}

extension String {
    
    /// Append html format
    /// - Parameter contentWidth: passing content width
    /// - Returns: return string values.
    func appendingHtmlFormat(contentWidth: CGFloat) -> String {
        let html = """
        <html>
        <head>
        <meta name="viewport", content="width=\(contentWidth), initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no\">
        <style>
        body { font-size: 100%; font-family:Georgia !important; line-height:1.4; }
        p { !important; font-family:Georgia; }
        span { line-height:normal !important }
        table { width: 100% !important;}
        img { max-width:100%; width: 100%; height:auto; padding:0; border:0; margin:0; vertical-align:bottom;}
        </style>
        </head>
        <style>
        @media (prefers-color-scheme: dark) {body {color: white;}a:link {color: #0096e2;}a:visited {color: #9d57df;}}
        img{ display: inline; width: 100% !important; height: auto; max-width: 100%; border-radius: 10px; }
        video{ display: inline; height: auto; max-width: 100%; max-height: 200px; border-radius: 10px; }
        </style>
        <body>
        \(self)
        </body>
        </html>
        """
        return html
    }
}

extension NumberFormatter {
    
    /// To number formatter percentage value
    static var percentage: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.maximumFractionDigits = .zero
        return numberFormatter
    }
}

extension Double {
    
    /// To convert percentage value to round
    var percentageValue: String? {
        return NumberFormatter.percentage.string(from: self as NSNumber)
    }
}

extension URL {
    
    /// To check mime type from the url
    /// - Returns: return string value
    func mimeType() -> String {
        let pathExtension = self.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    
    /// To contains image for boolean
    var containsImage: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeImage)
    }
    
    /// To contains audio for boolean
    var containsAudio: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeAudio)
    }
    
    /// To contains video for boolean
    var containsVideo: Bool {
        let mimeType = self.mimeType()
        guard  let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeMovie)
    }
}

/// To used for convert string to double
extension String {
    
    /// To convert string to double.
    ///
    /// - Returns: return double values.
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
