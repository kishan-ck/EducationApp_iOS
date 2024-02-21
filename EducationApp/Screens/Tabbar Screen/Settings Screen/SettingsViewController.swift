//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

class SettingsViewController: BaseViewController {
    
    //MARK: - IBOutlet Declaration
    @IBOutlet weak var settingsTableView: UITableView?
    
    //MARK: - Variable Declaration
    var settingsTableDataSources = SettingsTableDataSources()
    
    /// settingsArray array of [[String: Any]] that displays title and Id.
    var settingsArray: [[String: Any]] = [
        ["title": "PROFILE", "image": "ic_profile", "id": "1"],
        ["title": "CHANGE_PASSWORD", "image": "ic_change_password", "id": "2"],
        ["title": "EMAIL_US", "image": "ic_call_dark", "id": "3"],
        ["title": "INFORMATION", "image": "ic_info", "id": "4"],
        ["title": "SHARE_APP", "image": "ic_share", "id": "5"],
        ["title": "RATE_US", "image": "ic_rating", "id": "6"],
        ["title": "APP_INTRODUCTION", "image": "ic_app_intro", "id": "7"],
        ["title": "LOG_OUT", "image": "ic_logout", "id": "8"]
    ]
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView?.setDataSourceDelegate(datasourceAndDelegate: settingsTableDataSources, tableCell: "SettingsTableViewCell")
        settingsTableDataSources.settingsArray = settingsArray
    }
    
    /// View will Appear
    ///
    /// - Parameter animated: passing true or false
    /// - Purpose : Called when view will appear
    /// - Description : To navigation bar after view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
    }
}

//MARK: - UI Functions
extension SettingsViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        navigationBarWithRightButtonTransparent(isShowBackButton: false, showTitle: "SETTINGS".localized, isShowSearchButton: false)
    }
}
