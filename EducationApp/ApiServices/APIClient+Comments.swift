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
    
    /// Comments list API that will provide list of different comments list.
    /// - Parameters:
    ///   - postId: passing post id
    ///   - page: passing page index value
    ///   - parameters: passing parameters
    ///   - isShowloader: passing show loader boolean flag
    ///   - result: provide list of posts listing data.
    ///   - failure: failer will show the error string
    public func getCommentsList(postId: Int, page: Int, parameters: Parameters, isShowloader: Bool, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .get_comments(postId, page, 10), parameters : parameters, method : .get, isShowloader: isShowloader) { responseObj in
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
    
    /// Comments create API that will provide list of different comments list.
    /// - Parameters:
    ///   - postId: passing post id
    ///   - parameters: passing parameters
    ///   - result: provide list of comments listing data.
    ///   - failure: failer will show the error string
    public func createCommentsList(postId: Int, parameters: Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .post_comment(postId), parameters : parameters, method : .post) { responseObj in
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
    
    /// Comments delete API that will provide list of different comments list.
    /// - Parameters:
    ///   - postId: passing post id.
    ///   - parentId: passing parent id.
    ///   - parameters: passing parameters
    ///   - result: provide list of comments listing data.
    ///   - failure: failer will show the error string
    public func deleteCommentsList(postId: Int, parentId: Int, parameters: Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        let endPoint: APIEndPoint = parentId > 0 ? .delete_comment(postId, parentId) : .post_comment(postId)
        callService(serviceName : endPoint, parameters : parameters, method : .delete) { responseObj in
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
