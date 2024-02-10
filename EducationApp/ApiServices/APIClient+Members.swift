//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: - Class API

/// All API calls are goes from here so don't write any where else api calling code
extension APIClient {
    
    //MARK: - Members List API
    
    /// Members API that will give the user details
    /// - Parameters:
    ///   - type: passing type string value.
    ///   - searchTxt: passing search text.
    ///   - page: passing page number
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getMembersListApi(type: String, searchTxt: String, page: Int, parameters: Parameters, isShowloader: Bool, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .member_list(type, page, 10), parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
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
    
    /// Member details API that will give the member details
    /// - Parameters:
    ///   - memberId: passing member id.
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getMemberDetailsApi(memberId: Int, parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .member(memberId), parameters: parameters, method: .get) { responseObj in
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
    
    /// Members Activity Report Action API that will check report etc.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func membersActivityReportActionApi(parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .member_report, parameters: parameters, method: .post) { responseObj in
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
    
    /// Members Activity Action API that will check likes, save etc.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func membersActivityActionApi(parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .member_activity_action, parameters: parameters, method: .post) { responseObj in
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
    
    /// Members Followers API that will give the user details
    /// - Parameters:
    ///   - searchTxt: passing search text.
    ///   - page: passing page number
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getMembersFollowerListApi(enumForFollowingAndFollowers: enumForFollowingAndFollowers?, page: Int, parameters: Parameters, isShowloader: Bool, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        var endPoint: APIEndPoint?
        if enumForFollowingAndFollowers == .followers {
            endPoint = .follower_list(page, 10)
        } else {
            endPoint = .following_list(page, 10)
        }
        callService(serviceName: endPoint ?? .follower_list(page, 10), parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
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
    
    /// Members Following API that will give the user details
    /// - Parameters:
    ///   - searchTxt: passing search text.
    ///   - page: passing page number
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getMembersFollowingListApi(page: Int, parameters: Parameters, isShowloader: Bool, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .following_list(page, 10), parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
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
