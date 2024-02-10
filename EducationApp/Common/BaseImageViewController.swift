//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import Alamofire
import EventKit
import EventKitUI

/// BaseViewController is a common Background image used in every UIViewCotroller.
class BaseImageViewController: BaseViewController {
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        checkingControllerForDarkMode()
    }
        
    /// To check controller and manage the dark mode
    func checkingControllerForDarkMode(){
        switch self {
        case is ViewController:
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "img_screenDarkBackground")
            backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0)
            break
        default:
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "img_screenBackground")
            backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0)
            break
        }
    }
}

/// BaseViewController is a common Tab bar and Modification used in every UIViewCotroller.
class BaseViewController: UIViewController {
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// View will appeare
    ///
    /// - Parameter animated: passing true or false
    /// - Purpose : Called when view will appear
    /// - Description : To hide navigation bar after view will appear
    /// - Error : -
    /// - Dependency : -
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /// Set up transparent navigation bar with custom back button and feedack button
    /// - Parameters:
    ///   - isShowBackButton: passing show back button boolean flag.
    ///   - showTitle: passing show title string.
    func navigationBarWithRightButtonTransparent(isShowBackButton: Bool, showTitle: String? = "") {
        // set up navigation bar
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isHidden = false
        
        // set up back button
        if isShowBackButton {
            let backButton = UIButton()
            
            switch self {
            case is ViewController:
                backButton.setImage(UIImage(named: "ic_darkback")?.imageFlippedForRightToLeftLayoutDirection(), for: .normal)
                break
            default:
                backButton.setImage(UIImage(named: "ic_back")?.imageFlippedForRightToLeftLayoutDirection(), for: .normal)
                break
            }
            
    
            backButton.addTarget(self, action: #selector(self.backButtonAction(sender:)), for: .touchUpInside)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.navigationItem.title = showTitle
            self.view.backgroundColor = UIColor(named: "#F2F2F2 - #000D1C")
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: themeFont(size: 20, fontname: .georgiaBold), NSAttributedString.Key.foregroundColor: UIColor(named: "TextColor - #252A36") as Any]
        }
    }
    
    /*/// Click event for back button
    @objc func backButtonAction() {
        self.dismiss(animated: false, completion: nil)
        if let stack = self.navigationController?.viewControllers, stack.count > 1 {
            self.navigationController?.popViewController(animated: true)
        }
    }*/
    
    /// To used for back button event.
    ///
    /// - Parameter sender: passing sender object.
    @IBAction func backButtonAction(sender : UIButton){
        self.dismiss(animated: false, completion: nil)
        if let stack = self.navigationController?.viewControllers, stack.count > 1 {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /// Set navigation bar right button.
    ///
    /// - Parameters:
    ///   - titleString: passing title string
    ///   - titleColor: passing title color
    ///   - backgroundColor: passing background color
    ///   - titleFont: passing title font
    ///   - width: passing button width
    ///   - height: passing button height
    ///   - cornerRadius: passing corner radius of button
    /// - Purpose : Called to set right navigation button.
    /// - Description : Call to set right navigation button.
    /// - Error : -
    /// - Dependency : -
    func setRightMenuButton(titleString: String, titleColor: UIColor? = UIColor(named: "WhiteColor - #FFFFFF"), backgroundColor: UIColor? = UIColor(named: "FloatingYellow - #E3A130"), titleFont: UIFont? = themeFont(size: 15, fontname: .georgiaRegular), width: CGFloat, height: CGFloat, cornerRadius: CGFloat) {
        let setRightMenuButton = UIButton(type: .custom)
        setRightMenuButton.setTitle(titleString.localized, for: .normal)
        setRightMenuButton.titleLabel?.font = titleFont
        setRightMenuButton.titleLabel?.textAlignment = .center
        
        setRightMenuButton.setTitleColor(titleColor, for: .normal)
        setRightMenuButton.backgroundColor = backgroundColor
        
        setRightMenuButton.cornerRadius = cornerRadius
        setRightMenuButton.clipsToBounds = true
        setRightMenuButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        setRightMenuButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        setRightMenuButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        setRightMenuButton.addTarget(self, action: #selector(self.btnSetRightMenuButtonFired(sender:)), for: .touchUpInside)
        let rightBarBtnItem = UIBarButtonItem(customView: setRightMenuButton)
        self.navigationItem.rightBarButtonItem = rightBarBtnItem
    }
    
    /// Navigation right click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Purpose : Called when right navigation button is pressed.
    /// - Description : Call to perfrom action.
    /// - Error : -
    /// - Dependency : -
    @IBAction func btnSetRightMenuButtonFired(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Set flow layout to collection view object
    ///
    /// - Parameter collectionViewObject: passing collection view object
    func setFlowLayoutToCollectionView(collectionViewObject : UICollectionView){
        //let layout = TagFlowLayout()
        //layout.estimatedItemSize = CGSize(width: 140, height: 40)
        //collectionViewObject.collectionViewLayout = layout
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .center)
        layout.minimumInteritemSpacing = widthPer(per: 2.32)
        layout.minimumLineSpacing = widthPer(per: 2.32)
        collectionViewObject.collectionViewLayout = layout
    }
    
    /// To used for application status bar default style.
    func applicationStatusBarDefaultStyle(){
        UIApplication.shared.statusBarStyle = .default
    }
    
    /// To used for applicatin status bar light content style.
    func applicationStatusBarLightContentStyle(){
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    /// To handle the in app purchase error.
    /// - Parameter statusCode: passing status code
    func errorHandlingForInAppPurchase(statusCode: Int) {
        let status: Int = statusCode
        switch status {
        case 21000:
            makeToast(type: .info, title: APP_TITLE, message: "ERROR: The App Store could not read the JSON object you provided.")
            break
        case 21002:
            makeToast(type: .info, title: APP_TITLE, message: "ERROR: The data in the receipt-data property was malformed or missing.")
            break
        case 21003:
            makeToast(type: .info, title: APP_TITLE, message: "ERROR: The receipt could not be authenticated.")
            break
        case 21004:
            makeToast(type: .info, title: APP_TITLE, message: "ERROR: The shared secret you provided does not match the shared secret on file for your account.")
            break
        case 21005:
            makeToast(type: .info, title: APP_TITLE, message: "ERROR: The receipt server is not currently available.")
            break
        case 21006:
            makeToast(type: .info, title: APP_TITLE, message: "ERROR: This receipt is valid but the subscription has expired.")
            break
        case 21007:
            makeToast(type: .info, title: APP_TITLE, message: "ERROR: This receipt is from the test environment, but it was sent to the production environment for verification. Send it to the test environment instead.")
            break
        case 21008:
            makeToast(type: .info, title: APP_TITLE, message: "ERROR: This receipt is from the production environment, but it was sent to the test environment for verification. Send it to the production environment instead.")
            break
        case 21010:
            makeToast(type: .info, title: APP_TITLE, message: "ERROR: This receipt could not be authorized. Treat this the same as if a purchase was never made.")
            break
        case 21100..<21200:
            makeToast(type: .info, title: APP_TITLE, message: "ERROR: Internal data access error.")
            break
        default:
            makeToast(type: .info, title: APP_TITLE, message: "ERROR: The receipt is not available, and you won't be able to validate their in-app purchases without it.")
            break
        }
    }
}

//MARK: - Calendar Method
extension BaseViewController: EKEventEditViewDelegate {
    
    /// To add event to calendar
    /// - Parameters:
    ///   - eventObj: passing event object
    ///   - completion: handle completion block
    func addEventToCalendar(eventObj: json, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            DispatchQueue.main.async {
                if (granted) && (error == nil) {
                    let event = EKEvent(eventStore: eventStore)
                    event.title = eventObj.string(key: "event_title")
                    //event.notes = (eventObj.string(key: "description").htmlAttributedString()?.string ?? "") + "\n" + String(format: "%@ %@", "JOIN_MEETING_LINK".localized, eventObj.object(key: "zoom").string(key: "meeting_join_url"))
                    
                    let meeting_join_url = "Join Zoom Meeting: " + "" + eventObj.object(key: "zoom").string(key: "meeting_join_url")
                    
                    let zoom_meeting_id = eventObj.object(key: "zoom").string(key: "meeting_id")
                    let meeting_id = zoom_meeting_id == "" ? "" : ("\n\nMeeting ID: " + "" + zoom_meeting_id)
                    
                    let zoom_meeting_password = eventObj.object(key: "zoom").string(key: "meeting_password")
                    let meeting_password = zoom_meeting_password == "" ? "" : ("\nPasscode: " + "" + zoom_meeting_password)
                    
                    let descEvent = String(format: "%@%@%@", meeting_join_url, meeting_id, meeting_password)
                    event.notes = descEvent
                    
                    event.url = URL(string: eventObj.object(key: "zoom").string(key: "meeting_join_url"))
                    
                    let profileTimeZone = Config().getUser().object(key: "timezone").string(key: "timezone_identifier")
                    let start_date = convertDateAccordingToTimeZone(dateToConvert: eventObj.string(key: "start_date"), fromFormatter: YYYY_MM_DD_HH_MM_SS_FORMAT, toFormatter: DD_MM_YYYY_T_HH_MM_SS_FORMAT, toTimeZone: profileTimeZone.trim())
                    event.startDate = stringToDate(formatter: DD_MM_YYYY_T_HH_MM_SS_FORMAT, date: start_date)
                    
                    let end_date = convertDateAccordingToTimeZone(dateToConvert: eventObj.string(key: "end_date"), fromFormatter: YYYY_MM_DD_HH_MM_SS_FORMAT, toFormatter: DD_MM_YYYY_T_HH_MM_SS_FORMAT, toTimeZone: profileTimeZone.trim())
                    event.endDate = stringToDate(formatter: DD_MM_YYYY_T_HH_MM_SS_FORMAT, date: end_date)
                    
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    
                    /*// to save without presenting
                    do {
                        try eventStore.save(event, span: .thisEvent)
                    } catch let error as NSError {
                        print("failed to save event with error : \(error)")
                    }
                    print("Saved Event")*/
                    
                    // To present and save
                    let eventController = EKEventEditViewController()
                    eventController.event = event
                    eventController.eventStore = eventStore
                    eventController.editViewDelegate = self
                    self.present(eventController, animated: true, completion: nil)
                } else {
                    completion?(false, error as NSError?)
                }
            }
        })
    }
    
    /// To event edit view controller method.
    /// - Parameters:
    ///   - controller: getting controller object.
    ///   - action: getting action for the event.
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}
