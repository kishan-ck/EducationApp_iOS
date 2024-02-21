//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

/// LoginViewController is used to login to user's account by using dedicated email address and password.
class LoginViewController: UIViewController {
    
    //MARK: - IBOutlet Declaration
    
    /// emailTextField is a UITextField in which user can enter his email address.
    @IBOutlet weak var emailTextField: UITextField?
    
    /// passwordTextField is a UITextField in which user can enter password, which he entered which registering the account.
    @IBOutlet weak var passwordTextField: UITextField?
    
    /// showPasswordImageView UIImageView to display or hide passowrd.
    @IBOutlet weak var showPasswordImageView: UIImageView?
    
    /// signUpLabel to display sign up text.
    @IBOutlet weak var signUpLabel: UILabel?
    
    //MARK: - Variable Declaration

    /// To used to check welcome completed
    var isWelcomeCompleted: Int?
    
    /// To used for check login is succeed
    var isLoginSucceed: Int?
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
            emailTextField?.text = "dhruv.coderkube@gmail.com"
            passwordTextField?.text = "Dhruv@123"
        #else
        #endif
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
extension LoginViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        self.navigationController?.navigationBar.isHidden = true
        
        let attributedString = NSMutableAttributedString(string: "DO_NOT_HAVE_ACCOUNT".localized + "SIGN_UP".localized)
        attributedString.setColorForText("SIGN_UP".localized, with: UIColor(named: "#0961F5")!)
        signUpLabel?.attributedText = attributedString
    }
    
    /// Login API call with all validations.
    func loginAPI(){
        view.endEditing(true)
        
        if emailTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_EMAIL".localized, view: self.view)
            
        } else if isValidEmail(email: emailTextField?.text?.trim() ?? "") == false  {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_VALID_EMAIL".localized, view: self.view)
            
        } else if passwordTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_PASSWORD".localized, view: self.view)
            
        } else {
            let params: JSONDictionary = [
                "email": emailTextField?.text?.trim() as AnyObject,
                "password": passwordTextField?.text?.trim() as AnyObject]
            
            APIClient.sharedInstance.loginApi(parameters: params) { [weak self] responseObj in
                if(responseObj?.integer(key: "status") == 200){
                    self?.handleLoginResponse(responseObj: responseObj ?? [:])
                }
            } failure: { error in
                makeToast(type: .error, title: APP_TITLE, message: error ?? "", view: self.view)
            }
        }
    }
    
    /// To handle login and social login reposne.
    ///
    /// - Parameter responseObj: passing response json
    public func handleLoginResponse(responseObj: JSON){
        let responseData = responseObj.object(key: "data")
        Config().saveAuthToken(tokenString: responseData.string(key: "authToken"))
        
        let userData = responseData.dictionaryObject ?? [:]
        Config().saveUserData(object: userData)

        isWelcomeCompleted = Config().welcomeComplete
        isLoginSucceed = Config().getUser().count
        
        if (isLoginSucceed ?? 0) > 0 {
            KAPPDELEGATE.setUpHome()
            
        } else if isWelcomeCompleted == 0 {
            KAPPDELEGATE.setUpWelcome()
            
        } else {
            KAPPDELEGATE.setUpLogin()
        }
    }
}

//MARK: - IBAction Method
extension LoginViewController {
    
    /// loginButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It is used to login to user's account by using dedicated email address and password.
    @IBAction func signInButtonAction(_ sender: Any) {
        loginAPI()
    }
    
    /// forgotPasswordButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It will redirect user to ForgotPasswordViewController if user forgot his account password.
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        let viewControllr = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        navigationController?.pushViewController(viewControllr, animated: true)
    }
    
    /// signUpButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It will redirect user to SignUpViewController if user does not registered yet.
    @IBAction func signUpButtonAction(_ sender: Any) {
        let viewControllr = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        navigationController?.pushViewController(viewControllr, animated: true)
    }
    
    /// showPasswordButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It will be used for show and hide passoword.
    @IBAction func showPasswordButtonAction(_ sender: Any) {
        hideShowPassword(image: showPasswordImageView!, textField: passwordTextField!)
    }
}
