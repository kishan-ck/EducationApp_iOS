//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit

/// Common UINavigationController for the application.
class AppNavigationController: UINavigationController {
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// View will Appear
    ///
    /// - Parameter animated: passing true or false
    /// - Purpose : Called when view will appear
    /// - Description : To navigation bar after view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    /// preferredStatusBarStyle
    ///
    /// - Purpose : The preferred status bar style for the view controller.
    /// - Description : To set the preferred status bar style for the view controller.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if self.traitCollection.userInterfaceStyle == .dark {
            return .lightContent
        } else {
            return .default
        }
    }
}
