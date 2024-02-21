//
// Copyright (c) 2024 Education App All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIViewController Setup
extension UIViewController {
    
    /// Set up navigation swipe direction while changing languages
    func setSwipeDirection() {
        // right to left for arabic
        if getLangCode() == arabic {
            navigationController?.view.semanticContentAttribute = .forceRightToLeft
            navigationController?.navigationBar.semanticContentAttribute =  .forceRightToLeft
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            navigationController?.view.semanticContentAttribute = .forceLeftToRight
            navigationController?.navigationBar.semanticContentAttribute =  .forceLeftToRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    
    /// Provides calling functinality and calls to the given phone number.
    /// - Parameter phoneNumber: 9876543210
    func callNumber(phoneNumber: String) {
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                }
            } else {
                print("Calling functinality not support your device..")
                let alert = UIAlertController(title: "", message: "CALL_NOT_SUPPORTED".localized, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            print("Calling functinality not support your device..")
            let alert = UIAlertController(title: "", message: "CALL_NOT_SUPPORTED".localized, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /// Displays UIAlertController to show message.
    /// - Parameters:
    ///   - title: "Alert"
    ///   - msg: "are you sure want to logout?"
    ///   - alertOkTitle: "OK"
    ///   - cancelTitle: "Cancel"
    ///   - showCancelButton: true
    func showAlert(title: String? = nil, msg: String? = nil, alertOkTitle: String? = nil, okHandlor: @escaping()->Void = {}, cancelTitle: String? = "", showCancelButton: Bool = false, cancelHandlor: @escaping()->Void = {}, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: style)
        alert.addAction(UIAlertAction(title: alertOkTitle, style: .default, handler: { alt in
            okHandlor()
        }))
        if showCancelButton {
            alert.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: { alt in }))
            cancelHandlor()
        }
        UIApplication.topViewController()?.present(alert, animated: false, completion: nil)
    }
    
    /// Completion handler for call back
    typealias CompletionHandler = () -> Void
    
    /// Show Toast Message at bottom
    /// - Parameters:
    ///   - message: pass message string
    ///   - font: pass Font for the message
    func showToast(message : String, font: UIFont, completionHandler: CompletionHandler? = nil) {
        let toastLabel = PaddingLabel()
        toastLabel.topInset = 8
        toastLabel.bottomInset = 8
        toastLabel.leftInset = 8
        toastLabel.rightInset = 8
        toastLabel.textColor = UIColor(named: "WhiteColor - #FFFFFF")
        toastLabel.numberOfLines = 1
        toastLabel.backgroundColor = UIColor(named: "BlackColor")
        toastLabel.textAlignment = .center
        toastLabel.font = font
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds =  true
        
        self.view.addSubview(toastLabel)
        
        let fontAttributes = [NSAttributedString.Key.font: font]
        let text = message
        let size = (text as NSString).size(withAttributes: fontAttributes)
        toastLabel.frame = CGRect(x: 0, y: 0, width: size.width + 16, height: size.height + 16)
        toastLabel.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 50)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            if let completionHandler = completionHandler {
                completionHandler()
            }
        })
    }
    
    /// To scroll view with pagination for the api
    /// - Parameter scrollView: passing scroll view object
    /// - Returns: return true false boolean value
    func scrollViewPagination(scrollView: UIScrollView) -> Bool {
        let currentOffset: NSInteger = NSInteger(scrollView.contentOffset.y)
        let maximumOffset: NSInteger = NSInteger(scrollView.contentSize.height - scrollView.frame.size.height)
        if(maximumOffset - currentOffset <= 0){
            return true
        } else {
            return false
        }
    }
}
