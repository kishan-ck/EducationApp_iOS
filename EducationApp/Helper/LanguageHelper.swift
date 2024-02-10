//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation
import UIKit

///Language code for English Laguage
let english = "en"

///Language code for Arabic Laguage
let arabic = "ar"

///Language code for Franch Laguage
let french = "fr"

/// Key for application langage
let APPLE_LANGUAGE = "AppleLanguages"

/// set current lang code from UserDefaults.
func setLanguage(lng: String) {
    UserDefaults.standard.setValue(lng, forKey: APPLE_LANGUAGE)
    UserDefaults.standard.synchronize()
}

/// Get current lang code for localization
/// - Returns: retun short code `en` or `ar`
func getLanguage() -> String {
    if let arr = (UserDefaults.standard.object(forKey: APPLE_LANGUAGE) as? [String]) {
        return arr[0]
    }
    return "en"
}

/// Get current lang code
/// - Returns: retun lang code
func getLangCode () -> String{
    if let arr = (UserDefaults.standard.object(forKey: APPLE_LANGUAGE) as? [String]) {
        if arr[0].hasPrefix("ar"){
            return "en"
        }
    }
    return "en"
}
