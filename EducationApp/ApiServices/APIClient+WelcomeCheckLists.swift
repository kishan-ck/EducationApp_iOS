//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: - Class API

/// All API calls are goes from here so don't write any where else api calling code
extension APIClient {
    
    //MARK: - Welcome Check List API
    
    /// Welcome Check List API that will provide list of data for welcome check list.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - isShowloader: passing show loader flag
    ///   - result: provide list of data for welcome check list.
    ///   - failure: failer will show the error string
    public func welcomeCheckListApi(parameters: Parameters, isShowloader: Bool, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .welcomeChecklists, parameters : parameters, method : .get, isShowloader: isShowloader) { responseObj in
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
    
    //MARK: - Welcome Pop Up API
    
    /// Welcome Pop up API that will provide VideoUrl, description and title of Luminary mindset global leadership network.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide VideoUrl, description and title of Luminary mindset global leadership network.
    ///   - failure: failer will show the error string
    public func welcomePopUpApi(parameters: Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .welcomePopUp, parameters : Parameters(), method : .get, isShowloader: false) { responseObj in
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
}
