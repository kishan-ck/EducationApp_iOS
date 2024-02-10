//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/// Json dictionary format
typealias JSONDictionary = Dictionary<String, AnyObject>
typealias JSONStringDictionary = Dictionary<String, String>

/// Json array format
typealias JSONArray = Array<AnyObject>
typealias json = JSON

class APIClient {
    
    static let sharedInstance = APIClient()
    
    //MARK: - API Calling Function
    
    /// Common function that is used to call all the apis
    func callService(serviceName: APIEndPoint, parameters: Parameters, method: HTTPMethod, isShowloader: Bool = true, passToken: Bool = true, withSuccess: @escaping ((_ responseObj: JSONDictionary?) -> Void), failure: @escaping ((_ error: String?) -> Void)) {
        
        if(Connectivity.isConnectedToInternet){
            
            let pageUrlStr = Config.baseURL + serviceName.value
            
            var headers : HTTPHeaders = [:]
            if(passToken){
                headers = ["Authorization": Config().accessToken, "Content-Type": "application/json", "Accept": "application/json"]
            }else{
                headers = ["Content-Type": "application/json", "Accept": "application/json"]
            }

            print("pageUrlStr :- ", pageUrlStr)
            print("Headers :- ", headers)
            print("parameters :- ", parameters)
            
            if(isShowloader){
                showLoader()
            }
            
            AF.request(pageUrlStr, method : method, parameters : parameters, encoding : URLEncoding.queryString, headers : headers).responseJSON { response in
                switch response.result {
                    
                case .success(let JSON):
                    if let jsonDictionary = JSON as? JSONDictionary {
                        withSuccess(jsonDictionary)
                        
                        print("JSON Dictionary :- ", jsonDictionary)
                        print("Response Code :- ", jsonDictionary["status"]?.intValue ?? 0)
                        
                        if response.response?.statusCode == 401 {
                            print("unauthenticated")
                            KAPPDELEGATE.setUpUnauthenticated(message: jsonDictionary["message"] as? String)
                        }
                    } else {
                        failure("Request failed with error.")
                    }
                    
                    if(isShowloader){
                        hideLoader()
                    }
                    
                    break
                    
                case .failure(let error):
                    
                    if(error.responseCode == -1001){
                        print("Time out error.")
                    }
                    
                    failure("Request failed with error: \(error).")
                    //makeToast(type: .error, title: "PLEASE_TRY_AGAIN".localized, message: error.localizedDescription)
                    
                    if(isShowloader){
                        hideLoader()
                    }
                    
                    break
                }
            }
        } else {
            if(isShowloader){
                hideLoader()
            }
            
            let noInternetConnectionViewController = NoInternetConnectionViewController()
            noInternetConnectionViewController.modalPresentationStyle = .fullScreen
            KAPPDELEGATE.window?.rootViewController?.present(noInternetConnectionViewController, animated: false, completion: nil)
            noInternetConnectionViewController.reloadCallBack = {
                if(Connectivity.isConnectedToInternet){
                    if let topController = UIApplication.topViewController() {
                        if(topController.isKind(of: NoInternetConnectionViewController.self)){
                            topController.dismiss(animated: false, completion: nil)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.callService(serviceName: serviceName, parameters: parameters, method: method, isShowloader: isShowloader, passToken: passToken) { responseObj in
                            withSuccess(responseObj)
                        } failure: { error in
                            failure(error)
                        }
                    }
                } else {
                    makeToast(type: .error, title: APP_TITLE, message: "NO_INTERNET_CONNECTION".localized)
                }
            }
        }
    }

    /// Common function that is used to call all the apis
    func callUploadService(serviceName: APIEndPoint, parameters: Parameters, files: [JSONDictionary], method: HTTPMethod, isShowloader: Bool = true, passToken: Bool = true, withSuccess: @escaping ((_ responseObj: JSONDictionary?) -> Void), failure: @escaping ((_ error: String?) -> Void)) {
        
        if(Connectivity.isConnectedToInternet){
            
            let pageUrlStr = Config.baseURL + serviceName.value
            
            var headers : HTTPHeaders = [:]
            if(passToken){
                headers = ["Authorization": Config().accessToken, "Content-Type": "multipart/form-data", "Accept": "application/json"]
            }else{
                headers = ["Content-Type": "multipart/form-data", "Accept": "application/json"]
            }
            
            print("pageUrlStr :- ", pageUrlStr)
            print("Headers :- ", headers)
            print("parameters :- ", parameters)
            
            if(isShowloader){
                showLoader()
            }
            
            AF.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in parameters {
                    if let val = value as? [String] , let dataOfArray = stringArrayToData(stringArray: val) {
                        multipartFormData.append(dataOfArray, withName: key)
                    } else  if let val = value as? [Int] , let dataOfArray = intArrayToData(intArray: val) {
                        multipartFormData.append(dataOfArray, withName: key)
                    } else if let val = value as? JSONDictionary , let dataOfArray = stringDicToData(dic: val) {
                        multipartFormData.append(dataOfArray, withName: key)
                    } else {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
                
                for object in files {
                    if let data = object["data"] as? Data {
                        multipartFormData.append(data, withName: object.valueForKeyString("key"), fileName: object.valueForKeyString("name"), mimeType: "*/*")
                    }
                }
            }, to: pageUrlStr, method: .post, headers: headers).responseJSON { response in
                
                switch response.result {
                    
                case .success(let JSON):
                    
                    if let jsonDictionary = JSON as? JSONDictionary {
                        withSuccess(jsonDictionary)
                        
                        print("JSON Dictionary :- ", jsonDictionary)
                        print("Response Code :- ", jsonDictionary["status"]?.intValue ?? 0)
                        
                        if response.response?.statusCode == 401 {
                            print("unauthenticated")
                            KAPPDELEGATE.setUpUnauthenticated(message: jsonDictionary["message"] as? String)
                        }
                    }else{
                        failure("Request failed with error.")
                    }
                    
                    if(isShowloader){
                        hideLoader()
                    }
                    break
                    
                case .failure(let error):
                    
                    if(error.responseCode == -1001){
                        print("Time out error.")
                    }
                    
                    failure("Request failed with error: \(error).")
                    //makeToast(type: .error, title: "PLEASE_TRY_AGAIN".localized, message: error.localizedDescription)
                    
                    if(isShowloader){
                        hideLoader()
                    }
                    break
                }
            }
        }else{
            if(isShowloader){
                hideLoader()
            }
            
            let noInternetConnectionViewController = NoInternetConnectionViewController()
            noInternetConnectionViewController.modalPresentationStyle = .fullScreen
            KAPPDELEGATE.window?.rootViewController?.present(noInternetConnectionViewController, animated: false, completion: nil)
            noInternetConnectionViewController.reloadCallBack = {
                if(Connectivity.isConnectedToInternet){
                    if let topController = UIApplication.topViewController() {
                        if(topController.isKind(of: NoInternetConnectionViewController.self)){
                            topController.dismiss(animated: false, completion: nil)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.callService(serviceName: serviceName, parameters: parameters, method: method, isShowloader: isShowloader, passToken: passToken) { responseObj in
                            withSuccess(responseObj)
                        } failure: { error in
                            failure(error)
                        }
                    }
                } else {
                    makeToast(type: .error, title: APP_TITLE, message: "NO_INTERNET_CONNECTION".localized)
                }
            }
        }
    }
}
