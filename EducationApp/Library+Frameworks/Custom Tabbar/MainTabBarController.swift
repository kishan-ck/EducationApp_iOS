//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import Foundation
import ESTabBarController_swift

@available(iOS 13.0, *)
class MainTabBarController: UITabBarController {
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad(){
        super.viewDidLoad()

        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "HOME".localized, image: UIImage(named: "ic_home"), tag: 1)
        let firstNavigation = AppNavigationController(rootViewController: homeViewController)
        
        let myCoursesViewController = MyCoursesViewController()
        myCoursesViewController.tabBarItem = UITabBarItem(title: "COURSES".localized, image: UIImage(named: "ic_my_courses"), tag: 2)
        let secondNavigation = AppNavigationController(rootViewController: myCoursesViewController)

        let facultiesViewController = FacultiesViewController()
        facultiesViewController.tabBarItem = UITabBarItem(title: "FACULTIES".localized, image: UIImage(named: "ic_faculities"), tag: 3)
        let thirdNavigation = AppNavigationController(rootViewController: facultiesViewController)
        
        let settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem = UITabBarItem(title: "SETTINGS".localized, image: UIImage(named: "ic_settings"), tag: 4)
        let forthNavigation = AppNavigationController(rootViewController: settingsViewController)
        
        viewControllers = [firstNavigation, secondNavigation, thirdNavigation, forthNavigation]
    }
    
    /// View will Appear
    ///
    /// - Parameter animated: passing true or false
    /// - Purpose : Called when view will appear
    /// - Description : To navigation bar after view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.tintColor = UIColor(named: "#0961F5")
        self.tabBar.backgroundColor = UIColor(named: "#FFFFFF")
        self.tabBar.unselectedItemTintColor = UIColor(named: "#1E1E1E")
        
        let appearance = UITabBarItem.appearance()
        let tabBarAttributes = [NSAttributedString.Key.font: themeFont(size: 12, fontname: .poppinsSemiBold)]
        appearance.setTitleTextAttributes(tabBarAttributes, for: .normal)
    }
}
