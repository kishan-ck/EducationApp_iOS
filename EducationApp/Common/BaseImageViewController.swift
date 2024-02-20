//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import Alamofire

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
    func navigationBarWithRightButtonTransparent(isShowBackButton: Bool, showTitle: String? = "", isShowSearchButton: Bool) {
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
            backButton.setImage(UIImage(named: "ic_back")?.imageFlippedForRightToLeftLayoutDirection(), for: .normal)
            backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
            backButton.tintColor = UIColor(named: "#1E1E1E")
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        }
        
        // set up Title
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.navigationItem.title = showTitle
            self.view.backgroundColor = UIColor(named: "#FFFFFF")
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor(named: "#1E1E1E") as Any]
        }
        
        if isShowSearchButton {
            let searchButton = UIButton(type: .custom)
            searchButton.setImage(UIImage(named: "ic_search")?.imageFlippedForRightToLeftLayoutDirection(), for: .normal)
            searchButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            searchButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
            searchButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
            
            searchButton.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
        }
    }
    
    /// Click event for back button
    @objc func backButtonAction() {
        if let stack = self.navigationController?.viewControllers , stack.count > 1{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /// Click event for search button
    @objc func searchButtonAction() {
        print("POM POM")
    }
    
    /// To used for application status bar default style.
    func applicationStatusBarDefaultStyle(){
        UIApplication.shared.statusBarStyle = .default
    }
    
    /// To used for applicatin status bar light content style.
    func applicationStatusBarLightContentStyle(){
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
