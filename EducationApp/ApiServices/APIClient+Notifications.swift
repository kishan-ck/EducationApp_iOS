//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: - Class API

/// All API calls are goes from here so don't write any where else api calling code
extension APIClient {
    
    //MARK: - Notifications API
    
    /// Notifications list API that will provide list of different notification list settings.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide list of notifications listing settings.
    ///   - failure: failer will show the error string
    public func getNotificationsSettingsList(parameters: Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .notifications, parameters : parameters, method : .get) { responseObj in
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
    
    /// Notifications settings API that will provide list of different notification settings.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide list of notifications listing settings.
    ///   - failure: failer will show the error string
    public func updateNotificationsSettings(parameters: Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .notifications_settings, parameters : parameters, method : .get) { responseObj in
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
    
    /// Notifications list API that will provide list of different push notifications list.
    /// - Parameters:
    ///   - page: passing page number
    ///   - parameters: passing parameters
    ///   - isShowloader: passing hide/show loader flag
    ///   - result: provide list of posts listing data.
    ///   - failure: failer will show the error string
    public func getNotificationsList(page: Int, parameters: Parameters, isShowloader: Bool, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .push_notifications(page, 10), parameters : parameters, method : .get, isShowloader: isShowloader) { responseObj in
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
