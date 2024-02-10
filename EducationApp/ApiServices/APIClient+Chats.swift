//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: - Class API

/// All API calls are goes from here so don't write any where else api calling code
extension APIClient {
    
    //MARK: - Chat List API
    
    /// Chats API that will give the user details
    /// - Parameters:
    ///   - page: passing page number
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getChatsMemberListApi(page: Int, parameters: Parameters, isShowloader: Bool, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .chat_memberlist(page, 10), parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
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
    
    /// Chat message API that will give the chat details
    /// - Parameters:
    ///   - memberId: passing member id.
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getChatMessageApi(memberId: Int, parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .chat_message(memberId), parameters: parameters, method: .get) { responseObj in
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
