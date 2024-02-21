//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

/// All application configurations.
extension Bundle {
    
    /// To get all base url related configuration
    var educationConfig: [String: AnyObject] {
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "Education-Config", ofType: "plist") {
            nsDictionary = NSDictionary(contentsOfFile: path)
        }
        return nsDictionary as? [String : AnyObject] ?? [:]
    }
}

/// All application configurations.
class Config: NSObject {
    
    /// common baseURL for API URLs.
    static let hostURL = Bundle.main.educationConfig.valueForKeyString("host")
    static let baseURL = hostURL + Bundle.main.educationConfig.valueForKeyString("path")
    
    /// Store welcome complete screen variable
    var welcomeComplete: Int = USER_DEFAULTS_STANDARD.value(forKey: WELCOME_COMPLETE) as? Int ?? 0
    
    /// Stores access token retrieved from login or registration into userdefaults.
    var accessToken = "Bearer \(USER_DEFAULTS_STANDARD.value(forKey: "authToken") ?? "")"
    
    /// Stores all user information retrieved from login or registration into userdefaults.
    /// - Parameter object: key value dictionary
    func saveUserData(object: [AnyHashable: Any]){
        var userData = object
        userData = userData.nullKeyRemoval()
        USER_DEFAULTS_STANDARD.set(userData, forKey: "user")
        USER_DEFAULTS_STANDARD.synchronize()
    }
    
    func saveAuthToken(tokenString: String) {
        USER_DEFAULTS_STANDARD.set(tokenString, forKey: "authToken")
        USER_DEFAULTS_STANDARD.synchronize()
    }
    
    /// To get profile details from the user default
    ///
    /// - Returns: return json
    func getUser() -> JSON {
        let decoded = USER_DEFAULTS_STANDARD.object(forKey: "user")
        let object = JSON(decoded as Any)
        return object
    }
}
