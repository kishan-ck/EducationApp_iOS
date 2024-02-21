//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableDataSources: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variable Declaration
    
    /// settingsArray stores array of settings.
    var settingsArray : [[String: Any]]? {
        didSet{
            self.TableView?.reloadData()
        }
    }
    
    /// Asks the data source to return the number of sections in the table view.
    /// - Parameter tableView: UITableView
    /// - Returns: returns numer of sections in Int
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    /// Tells the data source to return the number of rows in a given section of a table view.
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: An index number identifying a section in tableView.
    /// - Returns: returns total numer of rows in Int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return settingsArray?.count ?? 0
    }
    
    /// Asks the data source for a cell to insert in a particular location of the table view.
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: An index path locating a row in tableView.
    /// - Returns: returns UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        
        let settingsObject = settingsArray?[indexPath.row]
        tableViewCell.titleLabel?.text = (settingsObject?["title"] as? String)?.localized
        tableViewCell.titleImageView?.image = UIImage(named: settingsObject?["image"] as? String ?? "")
        
        return tableViewCell
    }
    
    /// Tells the delegate a row is selected.
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: An index path locating a row in tableView.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingsObject = settingsArray?[indexPath.row]
        
        switch (settingsObject?["title"] as? String)?.localized {
        case "PROFILE".localized:
            print("PROFILE")
            let viewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
            viewController.hidesBottomBarWhenPushed = true
            tableView.parentViewController?.navigationController?.pushViewController(viewController, animated: true)
            break
            
        case "CHANGE_PASSWORD".localized:
            print("CHANGE_PASSWORD")
            let viewController = ChangePasswordViewController(nibName: "ChangePasswordViewController", bundle: nil)
            viewController.hidesBottomBarWhenPushed = true
            tableView.parentViewController?.navigationController?.pushViewController(viewController, animated: true)
            break
            
        case "EMAIL_US".localized:
            print("EMAIL_US")
            if MFMailComposeViewController.canSendMail() {
                let picker = MFMailComposeViewController()
                picker.mailComposeDelegate = self
                var sendTo = [String]()
                sendTo.append(supportEmail)
                picker.setToRecipients(sendTo)
                tableView.parentViewController?.present(picker, animated: true, completion: nil)
            } else {
                tableView.parentViewController?.showAlert(title: APP_TITLE, msg: "MAIL_BOX_NOT_SETUP".localized, alertOkTitle: "OK".localized, showCancelButton: false, style: .alert)
            }
            break
            
        case "INFORMATION".localized:
            print("INFORMATION")
            tableView.parentViewController?.showAlert(title: APP_TITLE, msg: "UIAlertController show small strings. when the size of string become larger. then some text from this alert is missing. is there any scrolling functionality available so that to scroll to the remaining text?".localized, alertOkTitle: "OK".localized, showCancelButton: false, style: .alert)
            break
            
        case "SHARE_APP".localized:
            print("SHARE_APP")
            let appContent = "Check out the App at: \(appURL)"
            let sharedObjects: [AnyObject] = [appContent as AnyObject]
            let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = tableView.parentViewController?.view
            tableView.parentViewController?.present(activityViewController, animated: true, completion: nil)
            
            break
            
        case "RATE_US".localized:
            print("RATE_US")
            if let url = URL(string: appURL) {
                UIApplication.shared.open(url)
            } else {
                makeToast(type: .error, title: APP_TITLE, message: "APP_URL_NOT_VALID".localized, view: tableView.parentViewController?.view)
            }
            break
            
        case "APP_INTRODUCTION".localized:
            print("APP_INTRODUCTION")
            tableView.parentViewController?.showAlert(title: APP_TITLE, msg: "UIAlertController show small strings. when the size of string become larger. then some text from this alert is missing. is there any scrolling functionality available so that to scroll to the remaining text?".localized, alertOkTitle: "OK".localized, showCancelButton: false, style: .alert)
            break
            
        case "LOG_OUT".localized:
            print("LOG_OUT")
            tableView.parentViewController?.showAlert(title: APP_TITLE, msg: "LOGOUT_MESSAGE".localized, alertOkTitle: "YES".localized, okHandlor: {
                KAPPDELEGATE.removeAllUserDefault()
                KAPPDELEGATE.setUpLogin()
    
            }, cancelTitle: "NO".localized, showCancelButton: true, style: .alert)
            break
            
        default:
            break
        }
    }
}

//MARK: - MFMailComposeViewControllerDelegate
extension SettingsTableDataSources : MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        TableView?.parentViewController?.dismiss(animated: true, completion: nil)
    }
}
