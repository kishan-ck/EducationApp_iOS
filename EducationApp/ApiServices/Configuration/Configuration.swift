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
    
    /// Stores access token retrieved from login or registration into userdefaults.
    var accessToken = "Bearer \(USER_DEFAULTS_STANDARD.value(forKey: "token") ?? "")"
    
    /// To store welcome checklist completed or not flag
    var welcomeChecklistComplete: Int = USER_DEFAULTS_STANDARD.value(forKey: "welcome_checklist_complete") as? Int ?? 0
    
    /// To store is guest login or not flag
    var isGuestLogin: Bool = USER_DEFAULTS_STANDARD.value(forKey: "is_guest_login") as? Bool ?? false
    
    /// Stores all user information retrieved from login or registration into userdefaults.
    /// - Parameter object: key value dictionary
    func saveUserData(object: [AnyHashable: Any]){
        var userData = object
        userData = userData.nullKeyRemoval()
        USER_DEFAULTS_STANDARD.set(userData, forKey: "user")
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
    
    /// To set user login info for the field.
    ///
    /// - Parameters:
    ///   - username: passing username string.
    ///   - password: passing password string.
    func setUserLoginInfo(username: String, password: String) {
        Config.setUsername(username)
        Config.setPassword(password)
    }
    
    /// To set user name for the login.
    ///
    /// - Parameter username: passing username string.
    class func setUsername(_ username: String) {
        USER_DEFAULTS_STANDARD.setValue(username, forKey: NS_USERNAME)
        USER_DEFAULTS_STANDARD.synchronize()
    }
    
    /// Get user name for the login.
    ///
    /// - Returns: return string.
    class func getUsername() -> String {
        var username: String = ""
        if USER_DEFAULTS_STANDARD.value(forKey: NS_USERNAME) != nil { username = (USER_DEFAULTS_STANDARD.value(forKey: NS_USERNAME) as? String ?? "") }
        return username
    }
    
    /// To set password into the user default.
    ///
    /// - Parameter pwd: passing password string.
    class func setPassword(_ pwd: String) {
        USER_DEFAULTS_STANDARD.setValue(pwd, forKey: NS_PASSWORD)
        USER_DEFAULTS_STANDARD.synchronize()
    }
    
    /// To get password from the user default.
    ///
    /// - Returns: return password string.
    class func getPassword() -> String {
        var pwd: String = ""
        if USER_DEFAULTS_STANDARD.value(forKey: NS_PASSWORD) != nil { pwd = (USER_DEFAULTS_STANDARD.value(forKey: NS_PASSWORD) as? String ?? "") }
        return pwd
    }
}
