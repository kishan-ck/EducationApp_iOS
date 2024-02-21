//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

class SubjectListViewController: BaseViewController {
    
    //MARK: - IBOutlet Declaration
    @IBOutlet weak var subjectCollectionView: UICollectionView?
    @IBOutlet weak var searchBar: UISearchBar?
    
    //MARK: - Variable Declaration
    var subjectCollectionViewDataSource = SubjectCollectionViewDataSource()
    
    var semesterObject: json?
    var courseObj: json?
    
    /// semesterListArray stores array of semester list data.
    var subjectListArray = [json]()
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectCollectionView?.setDataSourceDelegate(datasourceAndDelegate: subjectCollectionViewDataSource, collectionCell: "SemesterCollectionViewCell")
        
        self.getSubjectList()
        subjectCollectionView?.addPullToRefresh {
            self.getSubjectList(isShowloader: false)
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
extension SubjectListViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        let title = (courseObj?.string(key: "coursename") ?? "") + " SEM - " + (semesterObject?.string(key: "semester") ?? "")
        navigationBarWithRightButtonTransparent(isShowBackButton: true, showTitle: title, isShowSearchButton: true)
        
        searchBar?.placeholder = "SEARCH".localized
    }
    
    /// getSubjectList() used to call semester List API.
    /// - Parameter isShowloader: passing show loader boolean
    func getSubjectList(isShowloader: Bool = true){
        subjectListArray.removeAll()
        
        APIClient.sharedInstance.getSubjectListApi(semesterID: semesterObject?.string(key: "_id") ?? "", parameters: [:]) { responseObj in
            let listArray = responseObj?.array(key: "data") ?? []
            self.subjectListArray = listArray

            self.subjectCollectionView?.stopPullToRefresh()
            self.subjectCollectionViewDataSource.subjectListArray = self.subjectListArray
        } failure: { error in
            self.subjectCollectionView?.stopPullToRefresh()
            makeToast(type: .error, title: APP_TITLE, message: error ?? "")
        }
    }
}

//MARK: - UISearchBarDelegate
extension SubjectListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            subjectCollectionViewDataSource.subjectListArray = subjectListArray
        } else {
            var filteredSubjectArray: [json] = []
            filteredSubjectArray = subjectListArray.filter({ (subjectObject) -> Bool in
                let subjectName: NSString = (subjectObject.string(key: "subject")) as NSString
                let range = subjectName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            subjectCollectionViewDataSource.subjectListArray = filteredSubjectArray
        }
        subjectCollectionView?.reloadData()
    }
}
