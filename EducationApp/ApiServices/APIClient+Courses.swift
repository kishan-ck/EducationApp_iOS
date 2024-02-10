//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: - Class API

/// All API calls are goes from here so don't write any where else api calling code
extension APIClient {
    
    //MARK: - Courses API
    
    /// Courses list API that will provide list of different courses list.
    /// - Parameters:
    ///   - isShowloader: passing hide/show loader flag
    ///   - type: passing type string value.
    ///   - page: passing page number
    ///   - parameters: passing parameters
    ///   - result: provide list of posts listing data.
    ///   - failure: failer will show the error string
    public func getCoursesList(type: String, page: Int, parameters: Parameters, isShowloader: Bool, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .courses(type, "ios", page, 10), parameters : parameters, method : .get, isShowloader: isShowloader) { responseObj in
            let object = JSON(responseObj as Any)
            if object["status"].intValue == 200 {
                result(object)
            } else {
                failure(object.string(key: "message"))
            }
        } failure : { error in
            failure(error)
        }
    }
    
    /// Courses API that will give the course details
    /// - Parameters:
    ///   - courseId: passing course id.
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getCourseApi(courseId: Int, parameters: Parameters, isShowloader: Bool = true, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .course(courseId), parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
            let object = JSON(responseObj as Any)
            if object["status"].intValue == 200 {
                result(object)
            } else {
                failure(object.string(key: "message"))
            }
        } failure : { error in
            failure(error)
        }
    }
    
    /// Coach API that will give the user details
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getCoursesCoachListApi(parameters: Parameters, isShowloader: Bool, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .course_coach_list, parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
            let object = JSON(responseObj as Any)
            if object["status"].intValue == 200 {
                result(object)
            } else {
                failure(object.string(key: "message"))
            }
        } failure : { error in
            failure(error)
        }
    }
    
    /// Courses Module API that will give the course details
    /// - Parameters:
    ///   - courseId: passing course id.
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getCourseModulesApi(courseId: Int, parameters: Parameters, isShowloader: Bool, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .course_modules(courseId), parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
            let object = JSON(responseObj as Any)
            if object["status"].intValue == 200 {
                result(object)
            } else {
                failure(object.string(key: "message"))
            }
        } failure : { error in
            failure(error)
        }
    }
    
    /// Courses Module Type API that will give the course details
    /// - Parameters:
    ///   - courseId: passing course id.
    ///   - courseType: passing course type
    ///   - parameters: passing parameters
    ///   - isShowloader: passing show loader boolean flag
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getCourseModulesTypeApi(courseId: Int, courseType: String, parameters: Parameters, isShowloader: Bool = true, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .course_module_type(courseId, courseType), parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
            let object = JSON(responseObj as Any)
            if object["status"].intValue == 200 {
                result(object)
            } else {
                failure(object.string(key: "message"))
            }
        } failure : { error in
            failure(error)
        }
    }
    
    /// User Quiz Answer API that will add answer.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func userQuizAnswerApi(parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .user_quiz_answer, parameters: parameters, method: .post) { responseObj in
            let object = JSON(responseObj as Any)
            if object["status"].intValue == 200 {
                makeToast(type: .success, title: APP_TITLE, message: object.string(key: "message"))
                result(object)
            } else {
                failure(object.string(key: "message"))
            }
        } failure : { error in
            failure(error)
        }
    }
    
    /// User Course Activity Update Status API that will update user course status.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func userCourseActivityUpdateStatusApi(parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .user_course_activity_update_status, parameters: parameters, method: .post, isShowloader: false) { responseObj in
            let object = JSON(responseObj as Any)
            if object["status"].intValue == 200 {
                //makeToast(type: .success, title: APP_TITLE, message: object.string(key: "message"))
                result(object)
            } else {
                failure(object.string(key: "message"))
            }
        } failure : { error in
            failure(error)
        }
    }
    
    /// Course Transaction API that will course payment.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func courseTransactionApi(parameters: Parameters, isShowloader: Bool = true, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .course_transaction, parameters: parameters, method: .post, isShowloader: isShowloader) { responseObj in
            let object = JSON(responseObj as Any)
            if object["status"].intValue == 200 {
                makeToast(type: .success, title: APP_TITLE, message: object.string(key: "message"))
                result(object)
            } else {
                failure(object.string(key: "message"))
            }
        } failure : { error in
            failure(error)
        }
    }
    
    /// Interactive workbook web url API that will load the data.
    /// - Parameters:
    ///   - parameters: passig parameters
    ///   - result: provide contact support data
    ///   - failure: failure will show the error string
    public func interactiveWorkbookWebUrlApi(parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .interactive_workbook_web_url, parameters: parameters, method: .get, isShowloader: false) { responseObj in
            let object = JSON(responseObj as Any)
            if object["status"].intValue == 200 {
                result(object)
            } else {
                failure(object.string(key: "message"))
            }
        } failure : { error in
            failure(error)
        }
    }
    
    /// Course Transaction API that will course payment.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func courseReceiptValidateApi(parameters: Parameters, isShowloader: Bool = true, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callAlamofireURLSessionService(serviceName: .verify_receipt, parameters: parameters, method: .post, isShowLoader: isShowloader) { responseObj in
            let object = JSON(responseObj as Any)
            if object["statusCode"].intValue == 200 {
                result(object)
            } else {
                DispatchQueue.main.async {
                    failure(object.string(key: "message"))
                }
            }
        } failure : { error in
            failure(error)
        }
    }
}
