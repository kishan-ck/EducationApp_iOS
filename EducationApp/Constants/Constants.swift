//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import JGProgressHUD

//MARK: - Common Constant

/// To used for app title
let APP_TITLE = "APP_TITLE".localized

/// To used please wait string for progress
let PLEASE_WAIT = "PLEASE_WAIT".localized

/// To used for app delegate constant
let KAPPDELEGATE = UIApplication.shared.delegate as! AppDelegate

/// To used for check screen width
let screenWidth = UIScreen.main.bounds.size.width

/// To used for check screen height
let screenHeight = UIScreen.main.bounds.size.height

/// To used for max lengths for textfield
var maxLengths = [UITextField: Int]()

/// To used for show progress hud view
var hud = JGProgressHUD(style: .dark)

/// To used for user default standard constant
let USER_DEFAULTS_STANDARD = UserDefaults.standard

//MARK: - Completion Handler

/// Completion handler for api
typealias intCompletionHandler = (Int) ->  Void

/// Completion handler for api
typealias stringCompletionHandler = (String) ->  Void

/// Completion handler for api
typealias completionHandler = ([String : Any]) -> Void

/// Reload data handler for call back
typealias reloadDataHandler = (Any) -> Void

/// To used for handle completion object block
public typealias CompletionObject<T, K> = (_ response: T, _ response: K?) -> Void

/// Type alias for UIBarButtonItem closure.
typealias UIBarButtonItemTargetClosure = (UIBarButtonItem) -> ()

/// A type for our action block closure
typealias BlockButtonActionBlock = (_ sender: UIControl) -> Void

/// Type alias for UIScrollView closure.
typealias ScrollViewClosure = (UIScrollView) -> ()

/// To used for action block key
var ActionBlockKey: UInt8 = 0

/// Dictionary that stores all fonts to be used in the application.
var allFont: [String: [String: String]] = [:]

var showPassword : Bool = false

let supportEmail = "info@coderkube.com"

let appURL = "https://apps.apple.com/us/app/pdf-verse-pdf-converter/id6475039469"

//MARK: - Constants for USER_DEFAULTS_STANDARD keys

var WELCOME_COMPLETE = "WELCOME_COMPLETE"

var PROFILE_COMPLETE = "PROFILE_COMPLETE"
