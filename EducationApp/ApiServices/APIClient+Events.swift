//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: - Class API

/// All API calls are goes from here so don't write any where else api calling code
extension APIClient {
    
    //MARK: - Events List API
    
    /// Events API that will give the user details
    /// - Parameters:
    ///   - type: passing type string value.
    ///   - page: passing page number
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getEventsListApi(type: String, page: Int, parameters: Parameters, isShowloader: Bool, eventTypes: enumForEventTypes, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        if eventTypes == .saveEvent {
            callService(serviceName: .events(type, page, 10), parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
                let object = JSON(responseObj as Any)
                if object["status"].intValue == 200 {
                    result(object)
                } else {
                    failure(object.string(key: "message"))
                }
            } failure : { error in
                failure(error)
            }
        } else {
            callService(serviceName: .event_saved_draft(page, 10), parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
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
    
    /// Events details API that will give the events details
    /// - Parameters:
    ///   - eventId: passing event id.
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getEventDetailsApi(eventId: Int, parameters: Parameters, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .event(eventId), parameters: parameters, method: .get) { responseObj in
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
    
    /// Events create API that will provide list of different events list.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - files: passing files dictionary.
    ///   - result: provide list of events listing data.
    ///   - failure: failer will show the error string
    public func createEventsList(parameters: Parameters, files: [JSONDictionary], result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callUploadService(serviceName : .create_event, parameters : parameters, files: files, method : .post) { responseObj in
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
    
    /// Events edit API that will provide list of different events list.
    /// - Parameters:
    ///   - eventId: passing event id
    ///   - parameters: passing parameters
    ///   - files: passing files dictionary.
    ///   - result: provide list of events listing data.
    ///   - failure: failer will show the error string
    public func updateEventsList(eventId: Int, files: [JSONDictionary], parameters: Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callUploadService(serviceName : .event(eventId), parameters : parameters, files: files, method : .post) { responseObj in
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
    
    /// Events delete API that will provide list of different events list.
    /// - Parameters:
    ///   - eventId: passing event id
    ///   - parameters: passing parameters
    ///   - result: provide list of events listing data.
    ///   - failure: failer will show the error string
    public func deleteEventsList(eventId: Int, parameters: Parameters, result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        callService(serviceName : .event(eventId), parameters : parameters, method : .delete) { responseObj in
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
    
    /// Event Activity Action API that will check likes, save etc.
    /// - Parameters:
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    ///   - isShowloader: passing show loader flag
    public func eventActivityActionApi(parameters: Parameters, showToast: Bool = true, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .event_activity_action, parameters: parameters, method: .post) { responseObj in
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
    
    /// RSVP Members API that will give the user details
    /// - Parameters:
    ///   - eventId: passing event id
    ///   - type: passing type string value.
    ///   - page: passing page number
    ///   - parameters: passing parameters
    ///   - result: provide user data
    ///   - failure: failure will show the error string
    public func getRSVPListApi(eventId: Int, type: String, page: Int, parameters: Parameters, isShowloader: Bool, result: @escaping ((_ responseObj: JSON?) -> Void), failure: @escaping ((_ error: String?) -> Void)){
        callService(serviceName: .rsvp_list(eventId, type, page, 10), parameters: parameters, method: .get, isShowloader: isShowloader) { responseObj in
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
