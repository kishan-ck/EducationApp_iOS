//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation
import WebKit

//MARK: - WKWebView setup
extension WKWebView {
    
    /// Load HTML String same font like the web-view
    ///
    /// - Parameters:
    ///   - content: HTML content which we need to load in the web-view.
    ///   - baseURL: Content base url. It is optional.
    func loadHTMLStringWithMagic(content: String, baseURL: URL?) {
        /*let font = themeFont(size: 14, fontname: .georgiaRegular)
        let modifiedFont = NSString(format:"<span style=\"font-family: \(font.fontName); font-size: \(font.pointSize)\"></span>" as NSString) as String
        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"*/
        loadHTMLString(/*modifiedFont + headerString +*/ content, baseURL: baseURL)
    }
}
