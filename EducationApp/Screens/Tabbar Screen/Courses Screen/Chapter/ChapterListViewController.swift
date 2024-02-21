//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

class ChapterListViewController: BaseViewController {
    
    //MARK: - IBOutlet Declaration
    @IBOutlet weak var chapterListTableView: UITableView?
    
    @IBOutlet weak var searchBar: UISearchBar?
    
    //MARK: - Variable Declaration
    var chapterListTableDataSources = ChapterListTableDataSources()
    
    var subjectObject: json?
    
    /// chapterListArray stores array of chapter list data.
    var chapterListArray = [json]()
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        chapterListTableView?.setDataSourceDelegate(datasourceAndDelegate: chapterListTableDataSources, tableCell: "CoursesTableViewCell")
        
        self.getChapterList()
        chapterListTableView?.addPullToRefresh {
            self.getChapterList(isShowloader: false)
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
extension ChapterListViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        navigationBarWithRightButtonTransparent(isShowBackButton: true, showTitle: subjectObject?.string(key: "subject"), isShowSearchButton: true)
        
        searchBar?.placeholder = "SEARCH".localized
    }
    
    /// getChapterList() used to call chapter List API.
    /// - Parameter isShowloader: passing show loader boolean
    func getChapterList(isShowloader: Bool = true){
        chapterListArray.removeAll()
        
        APIClient.sharedInstance.getChaterListApi(subjectID: subjectObject?.string(key: "_id") ?? "", parameters: [:]) { responseObj in
            let listArray = responseObj?.array(key: "data") ?? []
            self.chapterListArray = listArray

            self.chapterListTableView?.stopPullToRefresh()
            self.chapterListTableDataSources.chapterListArray = self.chapterListArray
            
        } failure: { error in
            self.chapterListTableView?.stopPullToRefresh()
            makeToast(type: .error, title: APP_TITLE, message: error ?? "")
        }
    }
}

//MARK: - UISearchBarDelegate
extension ChapterListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            chapterListTableDataSources.chapterListArray = chapterListArray
        } else {
            var filteredChaptersArray: [json] = []
            filteredChaptersArray = chapterListArray.filter({ (chaptersObject) -> Bool in
                let chapterName: NSString = chaptersObject.string(key: "chapterName") as NSString
                let range = chapterName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            chapterListTableDataSources.chapterListArray = filteredChaptersArray
        }
        chapterListTableView?.reloadData()
    }
}

