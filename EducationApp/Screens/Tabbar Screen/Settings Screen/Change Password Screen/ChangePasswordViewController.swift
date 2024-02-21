//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

class ChangePasswordViewController: BaseViewController {
    
    //MARK: - IBOutlet Declaration
    @IBOutlet weak var showOldPasswordTextField: UITextField?
    @IBOutlet weak var showNewPasswordTextField: UITextField?
    @IBOutlet weak var showConfirmNewPasswordTextField: UITextField?
    
    @IBOutlet weak var showOldPasswordImageView: UIImageView?
    @IBOutlet weak var showNewPasswordImageView: UIImageView?
    @IBOutlet weak var showConfirmNewPasswordImageView: UIImageView?
    
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
extension ChangePasswordViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        navigationBarWithRightButtonTransparent(isShowBackButton: true, showTitle: "CHANGE_PASSWORD".localized, isShowSearchButton: false)
    }
    
    /// changePasswordAPI() function used to call change password API.
    func changePasswordAPI(){
        view.endEditing(true)
        
        if showOldPasswordTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_OLD_PASSWORD".localized, view: self.view)
            
        } else if showNewPasswordTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_NEW_PASSWORD".localized, view: self.view)
            
        } else if (showNewPasswordTextField?.text?.trim() ?? "").count < 8 {
            makeToast(type: .error, title: APP_TITLE, message: "ENTER_VALID_NEW_PASSWORD".localized, view: self.view)
            
        } else if showConfirmNewPasswordTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_CONFIRM_PASSWORD".localized, view: self.view)
            
        } else if showNewPasswordTextField?.text?.trim() != showConfirmNewPasswordTextField?.text?.trim() {
            makeToast(type: .error, title: APP_TITLE, message: "NEW_PASSWORD_NOT_MATCH".localized, view: self.view)
            
        } else {
            
            let params : JSONDictionary = [
                "oldPassword": self.showOldPasswordTextField?.text as AnyObject,
                "newPassword": self.showNewPasswordTextField?.text as AnyObject]
            
            APIClient.sharedInstance.updatePasswordApi(parameters: params) { [weak self] responseObj in
                if(responseObj?.integer(key: "status") == 200){
                    self?.navigationController?.popViewController(animated: true)
                }
            } failure: { error in
                makeToast(type: .error, title: APP_TITLE, message: error ?? "")
            }
        }
    }
}

//MARK: - IBAction Method
extension ChangePasswordViewController {
    
    /// changePasswordButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It is used to edit user's password by using dedicated email address and password.
    @IBAction func changePasswordButtonAction(_ sender: Any) {
        changePasswordAPI()
    }
    
    /// showOldPasswordButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It will be used for show and hide passoword.
    @IBAction func showOldPasswordButtonAction(_ sender: Any) {
        hideShowPassword(image: showOldPasswordImageView!, textField: showOldPasswordTextField!)
    }
    
    /// showNewPasswordButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It will be used for show and hide Confirm passoword.
    @IBAction func showNewPasswordButtonAction(_ sender: Any) {
        hideShowPassword(image: showNewPasswordImageView!, textField: showNewPasswordTextField!)
    }
    
    /// showConfirmNewPasswordButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It will be used for show and hide Confirm passoword.
    @IBAction func showConfirmNewPasswordButtonAction(_ sender: Any) {
        hideShowPassword(image: showConfirmNewPasswordImageView!, textField: showConfirmNewPasswordTextField!)
    }
}
