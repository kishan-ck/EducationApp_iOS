//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

class FacultiesViewController: BaseViewController {
    
    //MARK: - IBOutlet Declaration
    @IBOutlet weak var facultiesTableView: UITableView?
    
    @IBOutlet weak var searchBar: UISearchBar?
    
    //MARK: - Variable Declaration
    var facultiesTableDataSources = FacultiesTableDataSources()
    
    /// facultiesListArray stores array of faculties list data.
    var facultiesListArray: [json]?
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        facultiesTableView?.setDataSourceDelegate(datasourceAndDelegate: facultiesTableDataSources, tableCell: "FacultiesTableViewCell")
        
        self.getFacultiesList()
        facultiesTableView?.addPullToRefresh {
            self.getFacultiesList(isShowloader: false)
        }
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
extension FacultiesViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        navigationBarWithRightButtonTransparent(isShowBackButton: false, showTitle: "FACULTIES".localized, isShowSearchButton: true)
        
        searchBar?.placeholder = "SEARCH".localized
    }
    
    /// getFacultiesList() used to call faculties List API.
    /// - Parameter isShowloader: passing show loader boolean
    func getFacultiesList(isShowloader: Bool = true){
        self.facultiesListArray = [json]()
        self.facultiesListArray?.removeAll()
        
        //let collegeId = Config().getUser().object(key: "student_course_details").object(key: "college_details").string(key: "_id")
        APIClient.sharedInstance.getAllFacultiesListApi(parameters: [:], isShowloader: isShowloader) { responseObj in
            let listArray = responseObj?.array(key: "data") ?? []
            self.facultiesListArray = listArray

            self.facultiesTableView?.stopPullToRefresh()
            self.facultiesTableDataSources.facultiesArray = self.facultiesListArray
        } failure: { error in
            self.facultiesTableView?.stopPullToRefresh()
            makeToast(type: .error, title: APP_TITLE, message: error ?? "")
        }
    }
}

//MARK: - UISearchBarDelegate
extension FacultiesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            
        } else {
            
        }
        facultiesTableView?.reloadData()
    }
}
