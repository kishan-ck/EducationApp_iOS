//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: - Class API

/// All API calls are goes from here so don't write any where else api calling code
extension APIClient {
    
    //MARK: - Plans List API
    
    /// Plans list API that will provide list of different plans.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide list of plans
    ///   - failure: failer will show the error string
    public func plansListApi(parameters: Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .plans, parameters : parameters, method : .get) { responseObj in
            let object = JSON(responseObj as Any)
            if object["status"].intValue == 200 {
                result(object["data"])
            } else {
                failure(object.string(key: "message"))
            }
        } failure : { error in
            failure(error)
        }
    }
    
    /// User API that will give the user details and purchase plan details
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide user data and plan purchase data
    ///   - failure: failure will show the error string
    public func getPurchasePlanApi(parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .purchase_plan, parameters: parameters, method: .get) { responseObj in
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
    
    /// Plan transaction API that will check plan is purchase or not etc.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - showToast: passing show toast flag
    ///   - isShowloader: passing show loader flag
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func planTransactionApi(parameters: Parameters, showToast: Bool = true, isShowloader: Bool = true, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .plan_transaction, parameters: parameters, method: .post, isShowloader: isShowloader) { responseObj in
            let object = JSON(responseObj as Any)
            if object["status"].intValue == 200 {
                if showToast {
                    makeToast(type: .success, title: APP_TITLE, message: object.string(key: "message"))
                }
                result(object)
            } else {
                failure(object.string(key: "message"))
            }
        } failure : { error in
            failure(error)
        }
    }
}
