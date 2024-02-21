//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON
import DropDown

class ProfileViewController: BaseViewController {
    
    //MARK: - IBOutlet Declaration

    @IBOutlet weak var firstNameTextField: UITextField?
    @IBOutlet weak var lastNameTextField: UITextField?
    @IBOutlet weak var genderTextField: UITextField?
    @IBOutlet weak var phoneNumberTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var selectCollegeTextField: UITextField?
    @IBOutlet weak var selectCourseTextField: UITextField?
    @IBOutlet weak var selectSemesterTextField: UITextField?
    
    @IBOutlet weak var genderTextFieldView: UIView?
    @IBOutlet weak var selectCollegeTextFieldView: UIView?
    @IBOutlet weak var selectCourseTextFieldView: UIView?
    @IBOutlet weak var selectSemesterTextFieldView: UIView?
    
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
        
        self.firstNameTextField?.text = Config().getUser().string(key: "firstName")
        self.lastNameTextField?.text = Config().getUser().string(key: "lastName")
        self.genderTextField?.text = Config().getUser().string(key: "gender")
        self.phoneNumberTextField?.text = Config().getUser().string(key: "mobileNum")
        self.emailTextField?.text = Config().getUser().string(key: "email")
        self.selectCollegeTextField?.text = Config().getUser().object(key: "student_course_details").object(key: "college_details").string(key: "collegeName")
        self.selectCourseTextField?.text = Config().getUser().object(key: "student_course_details").object(key: "course_details").string(key: "coursename")
        self.selectSemesterTextField?.text = Config().getUser().object(key: "student_course_details").object(key: "semester_details").string(key: "semester")
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
extension ProfileViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        navigationBarWithRightButtonTransparent(isShowBackButton: true, showTitle: "EDIT_PROFILE".localized, isShowSearchButton: false)
        
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
    }
}

//MARK: - UITextFieldDelegate
extension ProfileViewController: UITextFieldDelegate {
    
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
extension ProfileViewController {
    
    /// editProfileButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It is used to edit user's data by using dedicated email address and password.
    @IBAction func editProfileButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
