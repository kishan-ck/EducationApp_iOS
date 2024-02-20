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
        navigationBarWithRightButtonTransparent(isShowBackButton: true, isShowSearchButton: false)
    }
    
    func forgotPasswordAPI() {
        view.endEditing(true)
        
        if emailTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_EMAIL".localized, view: self.view)
            
        } else if isValidEmail(email: emailTextField?.text?.trim() ?? "") == false  {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_VALID_EMAIL".localized, view: self.view)
            
        } else {
            let params : JSONDictionary = [
                "email": emailTextField?.text?.trim() as AnyObject]
            APIClient.sharedInstance.forgotPasswordApi(parameters: params) { responseObj in
                if(responseObj?.integer(key: "status") == 200){
                    KAPPDELEGATE.setUpLogin()
                }
            } failure: { error in
                makeToast(type: .error, title: APP_TITLE, message: error ?? "", view: self.view)
            }
        }
    }
}

//MARK: - IBAction Method
extension ForgotPasswordViewController {
    
    /// sendButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It is used to login to apply forgot password functionality.
    @IBAction func sendButtonAction(_ sender: Any) {
        forgotPasswordAPI()
    }
}
