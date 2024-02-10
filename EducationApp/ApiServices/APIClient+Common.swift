//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: - Class API

/// All API calls are goes from here so don't write any where else api calling code
extension APIClient {
    
    //MARK: - Country List API
    
    /// Countries list API that will provide list of different country.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide list of countries
    ///   - failure: failer will show the error string
    public func countryListApi(parameters: Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .countries, parameters : parameters, method : .get, passToken: false) { responseObj in
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
    
    //MARK: - Timezone List API
    
    /// Timezone list API that will provide list of different times.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide list of timezones.
    ///   - failure: failer will show the error string
    ///   - id: Contains country ID
    public func timezoneListApi(id: Int, parameters: Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .timezoneDetails(id), parameters : parameters, method : .get, passToken: false) { responseObj in
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
    
    //MARK: - Contact Support API
    
    /// Contact support request API that will submit a request for query.
    /// - Parameters:
    ///   - parameters: passig parameters
    ///   - files: passing files dictionary
    ///   - result: provide contact support data
    ///   - failure: failure will show the error string
    public func contactSupportRequest(parameters: Parameters, files: [JSONDictionary], result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callUploadService(serviceName: .contact_support, parameters: parameters, files: files, method: .post, passToken: false) { responseObj in
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
    
    //MARK: - Terms of Use & Privacy Policy API
    
    /// Terms of use and Privacy Policy API that will load the data.
    /// - Parameters:
    ///   - type: passing type
    ///   - parameters: passig parameters
    ///   - result: provide contact support data
    ///   - failure: failure will show the error string
    public func termsOfUserAndPrivacyPolicyApi(type: String, parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .cms_pages(type), parameters: parameters, method: .get, isShowloader: false, passToken: false) { responseObj in
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
    
    //MARK: - Global Search API
    
    /// Global search API that will search global record.
    /// - Parameters:
    ///   - searchTxt:passing search text.
    ///   - parameters: passig parameters
    ///   - isShowloader: passing show loader boolean flag
    ///   - result: provide contact support data
    ///   - failure: failure will show the error string
    public func globalSearchAPI(searchTxt: String, parameters: Parameters, isShowloader: Bool, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .global_search(searchTxt), parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
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
    
    /// Version control api method
    ///
    /// - Parameters:
    ///   - parameters: passing parameter
    ///   - result: getting result handler
    ///   - failure: getting failure handler
    public func checkVersionControl(parameters : Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName: .version_control, parameters: parameters, method: .get, isShowloader: false, passToken: false) { responseObj in
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
    
    /// Delete Account API that will allow user to logout from logged in account.
    /// - Parameters:
    ///   - userId: passing user id
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func deleteAccountApi(userId: Int, parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .delete_account(userId), parameters: parameters, method: .delete) { responseObj in
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
