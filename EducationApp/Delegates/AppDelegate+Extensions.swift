//
// Copyright (c) 2024 Education App All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import SwiftyJSON

//MARK: - AppDelegate setup
extension AppDelegate {
    
    /// This function will root to LoginViewController and redirect there.
    func setUpLogin() {
        let loginViewController = LoginViewController.init(nibName: "LoginViewController", bundle: nil)
        window?.rootViewController = AppNavigationController(rootViewController: loginViewController)
        window?.makeKeyAndVisible()
    }
    
    /// This function will root to HomeViewController and redirect there.
    func setUpHome() {
        let mainTabBarController = MainTabBarController.init(nibName: "MainTabBarController", bundle: nil)
        window?.rootViewController = mainTabBarController
        window?.makeKeyAndVisible()
    }
    
    /// This function will root to WelcomeViewController and redirect there.
    func setUpWelcome() {
        let welcomeViewController = WelcomeViewController.init(nibName: "WelcomeViewController", bundle: nil)
        window?.rootViewController = AppNavigationController(rootViewController: welcomeViewController)
        window?.makeKeyAndVisible()
    }
    
    /// Setup unauthenticate message and redirect user to LoginViewController.
    /// - Parameter message: message value in String
    func setUpUnauthenticated(message : String?) {
        DispatchQueue.main.async {
            self.window?.rootViewController?.showAlert(title: APP_TITLE, msg: message, alertOkTitle: "OK".localized, okHandler: {
                KAPPDELEGATE.removeAllUserDefault()
                KAPPDELEGATE.setUpLogin()
            }, cancelTitle: "", showCancelButton: false)
        }
    }
    
    /// To used this function for remove all user default data from the app.
    func removeAllUserDefault() {
        USER_DEFAULTS_STANDARD.removeObject(forKey: "user")
        USER_DEFAULTS_STANDARD.removeObject(forKey: "token")
    }
    
    /// To used for main root object.
    var window: UIWindow? {
        if #available(iOS 13, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
            return window
        }
        guard let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window else { return nil }
        return window
    }
    
    /// To change Language of application.
    /// - Parameter languageCode: passes language code for changing language.
    func changeLanguage(_ languageCode: String) {
        var setLanguageCode: String = ""
        
        if let arr = (UserDefaults.standard.object(forKey: APPLE_LANGUAGE) as? [String]) {
            print("Language....\(languageCode)")
            setLanguageCode = languageCode
            if arr[0] == languageCode { return }
        }
        
        UserDefaults.standard.set([languageCode], forKey: APPLE_LANGUAGE)
        UserDefaults.standard.synchronize()
        
        // Run time conversion if you want
        Bundle.setLanguages(languageCode)
        UserDefaults.standard.synchronize()
    }
    
    /// No Internet connection alert
    func lostInternet(){
        let noInternetConnectionViewController = NoInternetConnectionViewController()
        noInternetConnectionViewController.modalPresentationStyle = .fullScreen
        window?.rootViewController?.present(noInternetConnectionViewController, animated: false, completion: nil)
        noInternetConnectionViewController.reloadCallBack = {}
    }
    
    /// To dismiss lost internet screen when internet is on
    func dismissLostInternet(){
        if let topController = UIApplication.topViewController() {
            if(topController.isKind(of: NoInternetConnectionViewController.self)){
                topController.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    /// Subview no data found view inside UIView.
    ///
    /// - Parameters:
    ///   - imageString: passing image string.
    ///   - titleString: passing title string.
    ///   - descriptionString: passing description string.
    ///   - viewType: passing enum for empty view.
    ///   - hiddenViewType: passing hidden view type.
    ///   - subView: passing sub view view.
    func noDataFoundView(imageString: String? = "", titleString: String? = "", descriptionString: String? = "", viewType: enumForEmptyView? = .emptyView, hiddenViewType: enumForEmptyHiddenView? = nil, subView: UIView){
        self.removeNoDataFoundView(subView: subView)
        let nib = Bundle(for: type(of: self)).loadNibNamed("NoDataFoundView", owner: self, options: nil)
        let noDataFoundView = nib![0] as! NoDataFoundView
        
        if viewType == .emptyView {
            noDataFoundView.noDataFoundImageView?.image = UIImage(named: "ic_no_record")
            noDataFoundView.noDataFoundTitleLabel?.text = "NO_RECORD_AVAILABLE_TITLE".localized
            noDataFoundView.noDataFoundDescriptionLabel?.text = "NO_RECORD_AVAILABLE_DESCRIPTION".localized
        } else if viewType == .searchView {
            noDataFoundView.noDataFoundImageView?.image = UIImage(named: "ic_search_ops")
            noDataFoundView.noDataFoundTitleLabel?.text = "NO_SEARCH_RESULT_FOUND_TITLE".localized
            noDataFoundView.noDataFoundDescriptionLabel?.text = "NO_SEARCH_RESULT_FOUND_DESCRIPTION".localized
        }
        
        if imageString?.trim() != "" {
            noDataFoundView.noDataFoundImageView?.image = UIImage(named: imageString?.trim() ?? "")
        }
        if titleString?.trim() != "" {
            noDataFoundView.noDataFoundTitleLabel?.text = titleString?.trim() ?? ""
        }
        if descriptionString?.trim() != "" {
            let descString = String(format: "NO_RECORD_AVAILABLE_DESCRIPTIONS".localized, descriptionString?.trim() ?? "")
            noDataFoundView.noDataFoundDescriptionLabel?.text = descString
            //noDataFoundView.noDataFoundDescriptionLabel?.text = descriptionString?.trim() ?? ""
        }
        
        noDataFoundView.imageBackgroundView?.isHidden = true
        noDataFoundView.titleBackgroundView?.isHidden = true
        
        if hiddenViewType == .imageView {
            noDataFoundView.imageBackgroundView?.isHidden = true
        } else if hiddenViewType == .titleView {
            noDataFoundView.titleBackgroundView?.isHidden = true
        } else if hiddenViewType == .descriptionView {
            noDataFoundView.descriptionBackgroundView?.isHidden = true
        }
        
        noDataFoundView.tag = 100
        noDataFoundView.frame = subView.frame
        noDataFoundView.center = CGPoint(x: subView.frame.size.width / 2, y : subView.frame.size.height / 2)
        
        subView.addSubview(noDataFoundView)
    }
    
    /// Subview no data found view inside UIView.
    ///
    /// - Parameters:
    ///   - imageString: passing image string.
    ///   - titleString: passing title string.
    ///   - descriptionString: passing description string.
    ///   - viewType: passing enum for empty view.
    ///   - hiddenViewType: passing hidden view type.
    ///   - subView: passing sub view view.
    func noDataFoundDummyView(imageString: String? = "", titleString: String? = "", descriptionString: String? = "", viewType: enumForEmptyView? = .emptyView, hiddenViewType: enumForEmptyHiddenView? = nil, subView: UIView){
        self.removeNoDataFoundView(subView: subView)
        let nib = Bundle(for: type(of: self)).loadNibNamed("NoDataFoundView", owner: self, options: nil)
        let noDataFoundView = nib![0] as! NoDataFoundView
        
        if viewType == .emptyView {
            noDataFoundView.noDataFoundImageView?.image = UIImage(named: "ic_no_record")
            noDataFoundView.noDataFoundTitleLabel?.text = "NO_RECORD_AVAILABLE_TITLE".localized
            noDataFoundView.noDataFoundDescriptionLabel?.text = "NO_RECORD_AVAILABLE_DESCRIPTION".localized
        } else if viewType == .searchView {
            noDataFoundView.noDataFoundImageView?.image = UIImage(named: "ic_search_ops")
            noDataFoundView.noDataFoundTitleLabel?.text = "NO_SEARCH_RESULT_FOUND_TITLE".localized
            noDataFoundView.noDataFoundDescriptionLabel?.text = "NO_SEARCH_RESULT_FOUND_DESCRIPTION".localized
        }
        
        if imageString?.trim() != "" {
            noDataFoundView.noDataFoundImageView?.image = UIImage(named: imageString?.trim() ?? "")
        }
        if titleString?.trim() != "" {
            noDataFoundView.noDataFoundTitleLabel?.text = titleString?.trim() ?? ""
        }
        if descriptionString?.trim() != "" {
            let descString = String(format: "%@", descriptionString?.trim() ?? "")
            noDataFoundView.noDataFoundDescriptionLabel?.text = descString
            //noDataFoundView.noDataFoundDescriptionLabel?.text = descriptionString?.trim() ?? ""
        }
        
        noDataFoundView.imageBackgroundView?.isHidden = true
        noDataFoundView.titleBackgroundView?.isHidden = true
        
        if hiddenViewType == .imageView {
            noDataFoundView.imageBackgroundView?.isHidden = true
        } else if hiddenViewType == .titleView {
            noDataFoundView.titleBackgroundView?.isHidden = true
        } else if hiddenViewType == .descriptionView {
            noDataFoundView.descriptionBackgroundView?.isHidden = true
        }
        
        noDataFoundView.tag = 100
        noDataFoundView.frame = subView.frame
        noDataFoundView.center = CGPoint(x: subView.frame.size.width / 2, y : subView.frame.size.height / 2)
        
        subView.addSubview(noDataFoundView)
    }
    
    /// Remove from no data found view inside view.
    ///
    /// - Parameter subView: passing UIView.
    func removeNoDataFoundView(subView : UIView){
        if let subViewWithTag = subView.viewWithTag(100) {
            subViewWithTag.removeFromSuperview()
        }
    }
    
    /// Displaying alert view with action event.
    /// - Description : Call to display alert with action.
    func guestUserDialog(){
        let alert = UIAlertController(title: APP_TITLE, message: AppUtilities.appendDotAfterString(str: "GUEST_MESSAGE".localized), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "LOGIN".localized, style: .cancel) { (ok) in
            print("Guest login sign out.")
            KAPPDELEGATE.removeAllUserDefault()
            KAPPDELEGATE.setUpLogin()
        }
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "CANCEL".localized, style: .default, handler: { (cancel) in
            print("Guest login cancel.")
        })
        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
