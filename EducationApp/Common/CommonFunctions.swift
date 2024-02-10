//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AVKit
import AVFoundation
import EasyTipView

/// Set width in percentage according to screen width.
/// - Parameter per: 20
/// - Returns: 86
func widthPer(per : Float) -> CGFloat {
    return (UIScreen.main.bounds.size.width * CGFloat(per)) / 100
}

/// Set height in percentage according to screen height.
/// - Parameter per: 20
/// - Returns: 191.6
func heightPer(per : Float) -> CGFloat {
    return (UIScreen.main.bounds.size.height * CGFloat(per)) / 100
}

/// Enum for  notification type - success, error, info
enum NotificationsType {
    case success
    case error
    case info
}

/// To show toast message on particular event.
/// - Parameters:
///   - type: NotificationsType Enum - success, error, info
///   - title: Title for toast message in string value
///   - message: Message for toast message in string value
///   - view: passing view for sub view toast.
func makeToast(type: NotificationsType, title: String, message: String, view: UIView? = nil) {
    /*if(type == .success){
        CRNotifications.showNotification(type: CRNotifications.success, title: title.localized.capitalized, message: AppUtilities.appendDotAfterString(str: message.localized, capitalize: false), dismissDelay: 3)
    }else if(type == .error){
        CRNotifications.showNotification(type: CRNotifications.error, title: title.localized.capitalized, message: AppUtilities.appendDotAfterString(str: message.localized, capitalize: false), dismissDelay: 3)
    }else{
        CRNotifications.showNotification(type: CRNotifications.info, title: title.localized.capitalized, message: AppUtilities.appendDotAfterString(str: message.localized, capitalize: false), dismissDelay: 3)
    }*/
    if view == nil {
        let windowCount = UIApplication.shared.windows.count
        UIApplication.shared.windows[windowCount - 1].makeToast(AppUtilities.appendDotAfterString(str: message.localized, capitalize: false), duration: 3.0, position: .bottom)
    } else {
        view?.makeToast(AppUtilities.appendDotAfterString(str: message.localized, capitalize: false), duration: 3.0, position: .bottom)
    }
}

/// Shows Loader / Activity Indicator
func showLoader() {
    hud.textLabel.text = PLEASE_WAIT
    if let keyWindow = UIApplication.shared.windows.first {
        hud.show(in: keyWindow)
    }
}

/// Hides Loader /  Activity Indicator
func hideLoader() {
    hud.dismiss(animated: true)
}

/// This is for setup Constraint equeal to the super view constraint
/// - Parameter view: passing view.
func setEqualSuperView(_ view: UIView){
    view.translatesAutoresizingMaskIntoConstraints = false
    let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
    if (view.superview != nil) {
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: view, attribute: $0, relatedBy: .equal, toItem: view.superview, attribute: $0, multiplier: 1, constant: 0)
        })
    }
}

/// Checks Internet Connectivity
struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}

/// Converts value into Double
/// - Parameters:
///   - value: 10
///   - nullValue: 0.0
/// - Returns: returns converted value to double
func getDouble(value: Any?, nullValue: Double? = 0.0) -> Double {
    var fValue: Double = nullValue!
    if let val = value {
        if val is NSNull {
            return fValue
        } else {
            if val is Int {
                fValue = Double(val as! Int)
            } else if val is String {
                let stValue: String = val as! String
                fValue = (stValue as NSString).doubleValue
            } else if val is Float {
                fValue = Double(val as! Float)
            } else if val is Double {
                fValue = val as! Double
            } else {
                return fValue
            }
        }
    }
    return fValue
}

/// Regex for Email Validation
func isValidEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

/// Regex for Password Validation
func isPasswordStrength(password: String) -> Bool {
    let passRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*\\d)(?=.*[@$!%*?&_+*#^]).{8,}$"
    let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
    return passPred.evaluate(with: password)
}

/// Date to String Conversion
func dateToString(formatter: String, date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = formatter
    dateFormatter.timeZone = Calendar.current.timeZone
    dateFormatter.locale = Calendar.current.locale
    let finalDate: String = dateFormatter.string(from: date)
    return finalDate
}

/// String to Date Conversion
func stringToDate(formatter: String, date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = formatter
    dateFormatter.timeZone = Calendar.current.timeZone
    dateFormatter.locale = Calendar.current.locale
    let finalDate = dateFormatter.date(from: date) ?? Date()
    return finalDate
}

/// To convert date according to time zone
/// - Parameter dateToConvert: passing data to convert string
/// - Parameter dateFormatter: passing date formatter
/// - Parameter fromFormatter: passing from formatter
/// - Parameter fromTimeZone: passing from timezone
/// - Parameter toFormatter: passing to formatter
/// - Parameter toTimeZone: passing to timezone
/// - Returns: return string value
func convertDateAccordingToTimeZone(dateToConvert: String, fromFormatter: String, fromTimeZone: String = UTC_TIMEZONE, toFormatter: String, toTimeZone: String = TimeZone.current.identifier) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = fromFormatter
    dateFormatter.timeZone = TimeZone(identifier: fromTimeZone)
    let convertedDate = dateFormatter.date(from: dateToConvert)
    dateFormatter.dateFormat = toFormatter
    dateFormatter.timeZone = TimeZone(identifier: toTimeZone)
    if let dateString = dateFormatter.string(from: convertedDate ?? Date()) as? String {
        return dateString
    } else {
        return dateToConvert
    }
}

/// To convert the utc time zone
/// - Parameter dateToConvert: passing data to convert string
/// - Parameter dateFormatter: passing date formatter
/// - Returns: return string value
func convertToUTC(dateToConvert: String, dateFormatter: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormatter
    let convertedDate = formatter.date(from: dateToConvert)
    formatter.timeZone = TimeZone(identifier: "UTC")
    if let dateString = formatter.string(from: convertedDate ?? Date()) as? String {
        return dateString
    } else {
        return dateToConvert
    }
}

/// Generates Thumbnail image from video.
/// - Parameter url: video URL
/// - Returns: Returns Thumbnail image from video.
func getThumbnailImage(forUrl url: URL) -> UIImage? {
    let asset: AVAsset = AVAsset(url: url)
    let imageGenerator = AVAssetImageGenerator(asset: asset)
    do {
        let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
        return UIImage(cgImage: thumbnailImage)
    } catch let error {
        print(error)
    }
    return nil
}

/// To convert date formatter.
///
/// - Parameters:
///   - toConvertDateFormatter: Passing intial date formatter string.
///   - convertDateFormatter: Passing convert date formatter string.
///   - dateString: passing date string.
func convertDateFormatter(fromConvertDateFormatter: String, toConvertDateFormatter: String, dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = fromConvertDateFormatter
    let date = dateFormatter.date(from: dateString)
    dateFormatter.dateFormat = toConvertDateFormatter
    if let resultString = dateFormatter.string(from: date ?? Date()) as? String {
        return resultString
    } else {
        return dateString
    }
}
