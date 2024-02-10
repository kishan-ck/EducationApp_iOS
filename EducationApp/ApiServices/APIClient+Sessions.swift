//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: - Class API

/// All API calls are goes from here so don't write any where else api calling code
extension APIClient {
    
    //MARK: - Sessions API
    
    /// Sessions list API that will provide list of different sessions list.
    /// - Parameters:
    ///   - isShowloader: passing hide/show loader flag
    ///   - type: passing type string value.
    ///   - page: passing page number
    ///   - parameters: passing parameters
    ///   - result: provide list of posts listing data.
    ///   - failure: failer will show the error string
    public func getSessionsList(type: String, page: Int, parameters: Parameters, isShowloader: Bool, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .sessions(type, "ios", page, 10), parameters : parameters, method : .get, isShowloader: isShowloader) { responseObj in
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
    
    /// sessions API that will give the session details
    /// - Parameters:
    ///   - sessionId: passing session id.
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getSessionApi(sessionId: Int, parameters: Parameters, isShowloader: Bool = true, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .session(sessionId), parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
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
    public func getSessionCoachListApi(parameters: Parameters, isShowloader: Bool, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .session_coach_list, parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
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
    
    /// sessions Duration API that will give the session details
    /// - Parameters:
    ///   - sessionId: passing session id.
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getSessionDurationApi(sessionId: Int, parameters: Parameters, isShowloader: Bool, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .session_duration(sessionId), parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
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
    
    /// session Transaction API that will session payment.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func sessionTransactionApi(parameters: Parameters, isShowloader: Bool = true, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .session_transaction, parameters: parameters, method: .post, isShowloader: isShowloader) { responseObj in
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
    
    /// Book session web url API that will load the data.
    /// - Parameters:
    ///   - sessionDurationId: passing session duration id.
    ///   - parameters: passig parameters
    ///   - result: provide contact support data
    ///   - failure: failure will show the error string
    public func bookSessionWebUrlApi(sessionDurationId: Int, parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .stripe_session_payment_initialize(sessionDurationId, "ios"), parameters: parameters, method: .get) { responseObj in
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
    
    /// Calendly Book session web url API that will load the data.
    /// - Parameters:
    ///   - sessionId: passing session id.
    ///   - parameters: passig parameters
    ///   - result: provide contact support data
    ///   - failure: failure will show the error string
    public func calendlySessionWebUrlApi(sessionId: Int, parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .calendly_session_web_url, parameters: parameters, method: .get, isShowloader: false) { responseObj in
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
    
    /// OneTwoOneSession list API that will provide list of different sessions list.
    /// - Parameters:
    ///   - page: passing page number
    ///   - parameters: passing parameters
    ///   - isShowloader: passing hide/show loader flag
    ///   - result: provide list of posts listing data.
    ///   - failure: failer will show the error string
    public func getOneTwoOneSessionDetailsApi(page: Int, parameters: Parameters, isShowloader: Bool, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .one_two_one_session_details(page, 10), parameters : parameters, method : .get, isShowloader: isShowloader) { responseObj in
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
}
