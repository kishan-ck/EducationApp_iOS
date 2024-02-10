//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import SwiftyJSON

/// LoginViewController is used to login to user's account by using dedicated email address and password.
class LoginViewController: BaseImageViewController {
    
    //MARK: - IBOutlet Declaration
    
    //MARK: - Variable Declaration
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
            //emailTextField?.text = "denialsmith@gmail.com"
            //passwordTextField?.text = "Denialsmith@123"
        #else

        #endif
        
        print("Login screen load.")
    }
    
    /// View will Appear
    ///
    /// - Parameter animated: passing true or false
    /// - Purpose : Called when view will appear
    /// - Description : To navigation bar after view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
