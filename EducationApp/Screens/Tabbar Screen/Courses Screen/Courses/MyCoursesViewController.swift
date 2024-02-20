//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

class MyCoursesViewController: BaseViewController {
    
    //MARK: - IBOutlet Declaration
    @IBOutlet weak var coursesTableView: UITableView?
    
    @IBOutlet weak var searchBar: UISearchBar?
    
    //MARK: - Variable Declaration
    var coursesTableDataSources = CoursesTableDataSources()
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        coursesTableView?.setDataSourceDelegate(datasourceAndDelegate: coursesTableDataSources, tableCell: "CoursesTableViewCell")
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
    
    override func searchButtonAction() {
        searchBar?.isHidden.toggle()
        if !searchBar!.isHidden {
            searchBar?.becomeFirstResponder()
        } else {
            searchBar?.text = ""
            searchBar?.resignFirstResponder()
        }
    }
}

//MARK: - UI Functions
extension MyCoursesViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        navigationBarWithRightButtonTransparent(isShowBackButton: false, showTitle: "COURSES".localized, isShowSearchButton: true)
        
        searchBar?.placeholder = "SEARCH".localized
    }
}

//MARK: - UISearchBarDelegate
extension MyCoursesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            
        } else {
            
        }
        coursesTableView?.reloadData()
    }
}
