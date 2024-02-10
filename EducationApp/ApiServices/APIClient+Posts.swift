//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: - Class API

/// All API calls are goes from here so don't write any where else api calling code
extension APIClient {
    
    //MARK: - Posts API
    
    /// Posts list API that will provide list of different posts list.
    /// - Parameters:
    ///   - isShowloader: passing hide/show loader flag
    ///   - type: passing type string value.
    ///   - searchTxt:passing search text.
    ///   - page: passing page number  
    ///   - parameters: passing parameters
    ///   - result: provide list of posts listing data.
    ///   - failure: failer will show the error string
    public func getPostsList(type: String, searchTxt: String, page: Int, parameters: Parameters, isShowloader: Bool, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .posts(type, searchTxt, page, 10), parameters : parameters, method : .get, isShowloader: isShowloader) { responseObj in
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
    
    /// Posts create API that will provide list of different posts list.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide list of posts listing data.
    ///   - failure: failer will show the error string
    public func createPostsList(parameters: Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callUploadService(serviceName : .create_post, parameters : parameters, files: [], method : .post) { responseObj in
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
    
    /// Posts edit API that will provide list of different posts list.
    /// - Parameters:
    ///   - postId: passing post id
    ///   - parameters: passing parameters
    ///   - result: provide list of posts listing data.
    ///   - failure: failer will show the error string
    public func updatePostsList(postId: Int, parameters: Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callUploadService(serviceName : .post(postId), parameters : parameters, files: [], method : .post) { responseObj in
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
    
    /// Posts delete API that will provide list of different posts list.
    /// - Parameters:
    ///   - postId: passing post id.
    ///   - parameters: passing parameters
    ///   - result: provide list of posts listing data.
    ///   - failure: failer will show the error string
    public func deletePostsList(postId: Int, parameters: Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .post(postId), parameters : parameters, method : .delete) { responseObj in
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
    
    /// Posts API that will give the post details
    /// - Parameters:
    ///   - postId: passing post id.
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getPostApi(postId: Int, parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .post(postId), parameters: parameters, method: .get) { responseObj in
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
    
    /// Post Activity Action API that will check likes, save etc.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func postActivityActionApi(parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .post_activity_action, parameters: parameters, method: .post) { responseObj in
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
    
    /// Post Activity Report Action API that will check likes, save etc.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func postActivityReportActionApi(parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .report, parameters: parameters, method: .post) { responseObj in
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
    
    /// Post by filter list API that will provide list of different posts list.
    /// - Parameters:
    ///   - isShowloader: passing hide/show loader flag
    ///   - type: passing type string value.
    ///   - page: passing page number
    ///   - parameters: passing parameters
    ///   - result: provide list of posts listing data.
    ///   - failure: failer will show the error string
    public func getPostByFilterList(type: String, page: Int, parameters: Parameters, isShowloader: Bool, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .post_by_filter(type, page, 10), parameters : parameters, method : .get, isShowloader: isShowloader) { responseObj in
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
    
    /// Poll answer API that will check radio button the according the poll.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func pollAnswerApi(parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .poll_answer, parameters: parameters, method: .post) { responseObj in
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
}
