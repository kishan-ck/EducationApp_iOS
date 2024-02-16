//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

/// ForgotPasswordViewController is used when user forgot's his password.
class ForgotPasswordViewController: BaseViewController {
    
    //MARK: - IBOutlet Declaration
    
    /// emailTextField is a UITextField in which user can enter his email address.
    @IBOutlet weak var emailTextField: UITextField?
    
    //MARK: - Variable Declaration

    
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
        setUpUI()
    }
}

//MARK: - UI Functions
extension ForgotPasswordViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        navigationBarWithRightButtonTransparent(isShowBackButton: true)
    }
}

//MARK: - IBAction Method
extension ForgotPasswordViewController {
    
    /// sendButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It is used to login to apply forgot password functionality.
    @IBAction func sendButtonAction(_ sender: Any) {
        KAPPDELEGATE.setUpLogin()
    }
}
