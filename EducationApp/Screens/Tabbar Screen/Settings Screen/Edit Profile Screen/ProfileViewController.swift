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
    var collegeArray: [json]?
    var collegeData = [String]()
    var collegeId: String = ""
    
    var courseDropDown = DropDown()
    var courseArray: [json]?
    var courseData = [String]()
    var courseId: String = ""
    
    var semesterDropDown = DropDown()
    var semesterArray: [json]?
    var semesterData = [String]()
    var semesterId: String = ""
    
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
        collegeId = Config().getUser().object(key: "student_course_details").object(key: "college_details").string(key: "_id")
        
        self.selectCourseTextField?.text = Config().getUser().object(key: "student_course_details").object(key: "course_details").string(key: "coursename")
        courseId = Config().getUser().object(key: "student_course_details").object(key: "course_details").string(key: "_id")
        
        self.selectSemesterTextField?.text = Config().getUser().object(key: "student_course_details").object(key: "semester_details").string(key: "semester")
        semesterId = Config().getUser().object(key: "student_course_details").object(key: "semester_details").string(key: "_id")
    }
    
    /// View will Appear
    ///
    /// - Parameter animated: passing true or false
    /// - Purpose : Called when view will appear
    /// - Description : To navigation bar after view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
        getCollegesList()
        getCoursesList()
        getSemestersList()
    }
}

//MARK: - UI Functions
extension ProfileViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        navigationBarWithRightButtonTransparent(isShowBackButton: true, showTitle: "EDIT_PROFILE".localized, isShowSearchButton: false)
        
        genderTextField?.setRightPaddingPoints(14)
        selectCollegeTextField?.setRightPaddingPoints(14)
        selectCourseTextField?.setRightPaddingPoints(14)
        selectSemesterTextField?.setRightPaddingPoints(14)
        
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
    
    /// getCollegesList() used to call colleges List API.
    func getCollegesList(isClear: Bool = false){
        collegeArray?.removeAll()
        collegeData.removeAll()
        APIClient.sharedInstance.getCollegeListApi(parameters: [:]) { responseObj in
            let listArray = responseObj?.array(key: "data")
            self.collegeArray = listArray
            self.collegeData = self.collegeArray?.map({ $0.string(key: "collegeName").trim() }) ?? []
            
            self.collegeDropDown = commonDropdown(anchorView: self.selectCollegeTextFieldView!, dataSource: self.collegeData) { id, value in
                self.collegeId = self.collegeArray?[id].string(key: "_id") ?? ""
                self.selectCollegeTextField?.text = value
                
                self.getCoursesList(isClear: true)
            }
            
        } failure: { error in
            makeToast(type: .error, title: APP_TITLE, message: error ?? "")
        }
    }
    
    /// getCoursesList() used to call courses List API.
    func getCoursesList(isClear: Bool = false){
        if isClear {
            selectCourseTextField?.text = ""
        }
        
        courseArray?.removeAll()
        courseData.removeAll()
        APIClient.sharedInstance.getCoursesListApi(collegeId: self.collegeId, parameters: [:]) { responseObj in
            let listArray = responseObj?.array(key: "data")
            self.courseArray = listArray
            self.courseData = self.courseArray?.map({ $0.string(key: "coursename").trim() }) ?? []
            
            self.courseDropDown = commonDropdown(anchorView: self.selectCourseTextFieldView!, dataSource: self.courseData) { id, value in
                self.courseId = self.courseArray?[id].string(key: "_id") ?? ""
                self.selectCourseTextField?.text = value
                
                self.getSemestersList(isClear: true)
            }
            
        } failure: { error in
            makeToast(type: .error, title: APP_TITLE, message: error ?? "")
        }
    }
    
    /// getSemestersList() used to call semesters List API.
    func getSemestersList(isClear: Bool = false){
        if isClear {
            selectSemesterTextField?.text = ""
        }
        
        semesterArray?.removeAll()
        semesterData.removeAll()
        APIClient.sharedInstance.getSemestersListApi(courseId: self.courseId, parameters: [:]) { responseObj in
            let listArray = responseObj?.array(key: "data")
            self.semesterArray = listArray
            self.semesterData = self.semesterArray?.map({ $0.string(key: "semester").trim() }) ?? []
            
            self.semesterDropDown = commonDropdown(anchorView: self.selectSemesterTextFieldView!, dataSource: self.semesterData) { id, value in
                self.semesterId = self.semesterArray?[id].string(key: "_id") ?? ""
                self.selectSemesterTextField?.text = value
            }
            
        } failure: { error in
            makeToast(type: .error, title: APP_TITLE, message: error ?? "")
        }
    }
    
    /// editProfileApi() function used to call Edit Profile API.
    func editProfileApi(){
        view.endEditing(true)
        
        if firstNameTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_FIRST_NAME".localized, view: self.view)
            
        } else if lastNameTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_LAST_NAME".localized, view: self.view)
            
        } else if genderTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_SELECT_GENDER".localized, view: self.view)
            
        } else if emailTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_EMAIL".localized, view: self.view)
            
        } else if isValidEmail(email: emailTextField?.text?.trim() ?? "") == false {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_VALID_EMAIL".localized, view: self.view)
            
        } else if phoneNumberTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_NUMBER".localized, view: self.view)
            
        } else if phoneNumberTextField?.text?.trim().count ?? 0 < 10 {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_ENTER_VALID_NUMBER".localized, view: self.view)
            
        } else if selectCollegeTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_SELECT_COLLEGE".localized, view: self.view)
            
        } else if selectCourseTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_SELECT_COURSE".localized, view: self.view)
            
        } else if selectSemesterTextField?.text?.trim() == "" {
            makeToast(type: .error, title: APP_TITLE, message: "PLEASE_SELECT_SEMESTER".localized, view: self.view)
            
        } else {
        
            let params : JSONDictionary = [
                "firstName": self.firstNameTextField?.text?.trim() as AnyObject,
                "lastName": self.lastNameTextField?.text?.trim() as AnyObject,
                "mobileNum": self.phoneNumberTextField?.text?.trim() as AnyObject,
                "email": self.emailTextField?.text?.trim() as AnyObject,
                "gender": self.genderTextField?.text?.trim() as AnyObject,
                "college_id": self.collegeId as AnyObject,
                "course_id": self.courseId as AnyObject,
                "semester_id": self.semesterId as AnyObject]

            APIClient.sharedInstance.updateProfileApi(parameters: params) { [weak self] responseObj in
                if(responseObj?.integer(key: "status") == 200){
                    
                    let responseData = responseObj?.object(key: "data")
                    Config().saveAuthToken(tokenString: responseData?.string(key: "authToken") ?? "")
                    
                    let userData = responseData?.dictionaryObject ?? [:]
                    Config().saveUserData(object: userData)
                    
                    self?.navigationController?.popViewController(animated: true)
                }
            } failure: { error in
                makeToast(type: .error, title: APP_TITLE, message: error ?? "", view: self.view)
            }
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
            if collegeData.count == 0 {
                makeToast(type: .error, title: APP_TITLE, message: "NO_COLLEGE_DATA_FOUND".localized, view: self.view)
                return false
            }
            collegeDropDown.show()
            return false
            
        } else if textField == selectCourseTextField {
            if courseData.count == 0 {
                makeToast(type: .error, title: APP_TITLE, message: "NO_COURSE_DATA_FOUND".localized, view: self.view)
                return false
            }
            courseDropDown.show()
            return false
            
        } else if textField == selectSemesterTextField {
            if semesterData.count == 0 {
                makeToast(type: .error, title: APP_TITLE, message: "NO_SEMESTER_DATA_FOUND".localized, view: self.view)
                return false
            }
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
        editProfileApi()
    }
}
