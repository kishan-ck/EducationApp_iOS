//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

//MARK: - UIApplication setup
extension UIApplication {
    
    var keyWindowInConnectedScenes: UIWindow?{
        return windows.first(where: {$0.isKeyWindow})
    }
    
    /// To used for status bar view extension
    var statusBarView: UIView? {
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = UIColor.systemBackground
            UIApplication.shared.keyWindow?.addSubview(statusBar)
            return statusBar
        } else if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        } else {
            return nil
        }
    }
    
    /// To check screen top view controller
    /// - Parameter controller: passing controller object.
    /// - Returns: return controller.
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension UIApplication {
    
    /// Use for check keyboard is presented or not
    var isKeyboardPresented: Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"), self.windows.contains(where: { $0.isKind(of: keyboardWindowClass) }) {
            return true
        } else {
            return false
        }
    }
}
