//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        
        allFont["regular"] = ["name": "Poppins-Regular"]
        allFont["italic"] = ["name": "Poppins-Italic"]
        allFont["thin"] = ["name": "Poppins-Thin"]
        allFont["thinItalic"] = ["name": "Poppins-ThinItalic"]
        allFont["extraLight"] = ["name": "Poppins-ExtraLight"]
        allFont["extraLightItalic"] = ["name": "Poppins-ExtraLightItalic"]
        allFont["light"] = ["name": "Poppins-Light"]
        allFont["lightItalic"] = ["name": "Poppins-LightItalic"]
        allFont["medium"] = ["name": "Poppins-Medium"]
        allFont["mediumItalic"] = ["name": "Poppins-MediumItalic"]
        allFont["semiBold"] = ["name": "Poppins-SemiBold"]
        allFont["semiBoldItalic"] = ["name": "Poppins-SemiBoldItalic"]
        allFont["bold"] = ["name": "Poppins-Bold"]
        allFont["boldItalic"] = ["name": "Poppins-BoldItalic"]
        allFont["extraBold"] = ["name": "Poppins-ExtraBold"]
        allFont["extraBoldItalic"] = ["name": "Poppins-ExtraBoldItalic"]
        allFont["black"] = ["name": "Poppins-Black"]
        allFont["blackItalic"] = ["name": "Poppins-BlackItalic"]
        
        ReachabilityManager.sharedInstance.observeReachability()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

