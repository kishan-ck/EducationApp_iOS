//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation

//MARK: - Bundle setup
extension Bundle {
    
    static let once: Void = {
        object_setClass(Bundle.main, type(of: BundleEx()))
        object_setClass(Bundle(identifier:"com.apple.UIKit"), type(of: BundleUIKitEx()))
    }()
    
    
    /// set application language from bundle
    /// - Parameter language: "en", "ar"
    class func setLanguages(_ language: String?) {
        Bundle.once
        UserDefaults.standard.synchronize()
        
        let value = (language != nil ? Bundle.init(path: (Bundle.main.path(forResource: language, ofType: "lproj"))!) : nil)
        objc_setAssociatedObject(Bundle.main, &kBundleKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        if let uiKitBundle = Bundle(identifier: "com.apple.UIKit") {
            var valueUIKit: Bundle? = nil
            if let lang = language,
               let path = uiKitBundle.path(forResource: lang, ofType: "lproj") {
                valueUIKit = Bundle(path: path)
            }
            objc_setAssociatedObject(uiKitBundle, &kBundleUIKitKey, valueUIKit, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}
