//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON
import DropDown

/// SignUpViewController is used to sign up to user's account by using dedicated email address and password.
class SignUpViewController: UIViewController{
    
    //MARK: - IBOutlet Declaration

    @IBOutlet weak var firstNameTextField: UITextField?
    @IBOutlet weak var lastNameTextField: UITextField?
    @IBOutlet weak var genderTextField: UITextField?
    @IBOutlet weak var phoneNumberTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var confirmPasswordTextField: UITextField?
    @IBOutlet weak var selectCollegeTextField: UITextField?
    @IBOutlet weak var selectCourseTextField: UITextField?
    @IBOutlet weak var selectSemesterTextField: UITextField?
    
    @IBOutlet weak var showPasswordImageView: UIImageView?
    @IBOutlet weak var showConfirmPasswordImageView: UIImageView?
    
    @IBOutlet weak var genderTextFieldView: UIView?
    @IBOutlet weak var selectCollegeTextFieldView: UIView?
    @IBOutlet weak var selectCourseTextFieldView: UIView?
    @IBOutlet weak var selectSemesterTextFieldView: UIView?
    
    @IBOutlet weak var signInLabel: UILabel?
    
    //MARK: - Variable Declaration
    var genderDropDown = DropDown()
    let genderData = ["MALE".localized, "FEMALE".localized, "OTHER".localized]
    
    var collegeDropDown = DropDown()
    let collegeData = ["MALE".localized, "FEMALE".localized, "OTHER".localized]
    
    var courseDropDown = DropDown()
    let courseData = ["MALE".localized, "FEMALE".localized, "OTHER".localized]
    
    var semesterDropDown = DropDown()
    let semesterData = ["MALE".localized, "FEMALE".localized, "OTHER".localized]
    
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
extension SignUpViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        self.navigationController?.navigationBar.isHidden = true
        
        genderDropDown = commonDropdown(anchorView: genderTextFieldView!, dataSource: genderData) { id, value in
            self.genderTextField?.text = value
        }
        
        collegeDropDown = commonDropdown(anchorView: selectCollegeTextFieldView!, dataSource: collegeData) { id, value in
            self.selectCollegeTextField?.text = value
        }
        
        courseDropDown = commonDropdown(anchorView: selectCourseTextFieldView!, dataSource: courseData) { id, value in
            self.selectCourseTextField?.text = value
        }
        
        semesterDropDown = commonDropdown(anchorView: selectSemesterTextFieldView!, dataSource: semesterData) { id, value in
            self.selectSemesterTextField?.text = value
        }
            
        let attributedString = NSMutableAttributedString(string: "ALREADY_HAVE_ACCOUNT".localized + "SIGN_IN".localized)
        attributedString.setColorForText("SIGN_IN".localized, with: UIColor(named: "#0961F5")!)
        signInLabel?.attributedText = attributedString
    }
}

//MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    /// Asks the delegate whether to process the pressing of the Return button for the text field.
    /// - Parameter textField: The text field whose return button was pressed.
    /// - Returns: true if the text field should implement its default behavior for the return button; otherwise, false.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    /// Asks the delegate whether to begin editing in the specified text field.
    /// - Parameter textField: The text field in which editing is about to begin.
    /// - Returns: true if editing should begin or false if it should not.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == genderTextField {
            genderDropDown.show()
            return false
            
        } else if textField == selectCollegeTextField {
            collegeDropDown.show()
            return false
            
        } else if textField == selectCourseTextField {
            courseDropDown.show()
            return false
            
        } else if textField == selectSemesterTextField {
            semesterDropDown.show()
            return false
        }
        return true
    }
}

//MARK: - IBAction Method
extension SignUpViewController {
    
    /// signUpButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It is used to Sign Up to user's account by using dedicated email address and password.
    @IBAction func signUpButtonAction(_ sender: Any) {
        let viewController = LoginSuccessPopUpViewController(nibName: "LoginSuccessPopUpViewController", bundle: nil)
        viewController.completion = { dict in
            KAPPDELEGATE.setUpHome()
        }
        viewController.modalPresentationStyle = .custom
        present(viewController, animated: false, completion: nil)
    }
    
    /// signInButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It will redirect user to LoginViewController if user does not registered yet.
    @IBAction func signInButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    /// showPasswordButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It will be used for show and hide passoword.
    @IBAction func showPasswordButtonAction(_ sender: Any) {
        hideShowPassword(image: showPasswordImageView!, textField: passwordTextField!)
    }
    
    /// showConfirmPasswordButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It will be used for show and hide Confirm passoword.
    @IBAction func showConfirmPasswordButtonAction(_ sender: Any) {
        hideShowPassword(image: showConfirmPasswordImageView!, textField: confirmPasswordTextField!)
    }
}
