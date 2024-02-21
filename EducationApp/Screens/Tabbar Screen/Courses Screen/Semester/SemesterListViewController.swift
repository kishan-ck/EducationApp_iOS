//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

class SemesterListViewController: BaseViewController {
    
    //MARK: - IBOutlet Declaration
    @IBOutlet weak var semesterCollectionView: UICollectionView?
    @IBOutlet weak var courseLabel: UILabel?
    @IBOutlet weak var searchBar: UISearchBar?
    
    //MARK: - Variable Declaration
    var semesterCollectionViewDataSource = SemesterCollectionViewDataSource()
    
    var courseObj: json?
    
    /// semesterListArray stores array of semester list data.
    var semesterListArray = [json]()
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        semesterCollectionView?.setDataSourceDelegate(datasourceAndDelegate: semesterCollectionViewDataSource, collectionCell: "SemesterCollectionViewCell")
        
        self.getSemesterList()
        semesterCollectionView?.addPullToRefresh {
            self.getSemesterList(isShowloader: false)
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
extension SemesterListViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        navigationBarWithRightButtonTransparent(isShowBackButton: true, showTitle: "ALL_SEMESTER".localized, isShowSearchButton: true)
        
        searchBar?.placeholder = "SEARCH".localized
        
        let attributedString = NSMutableAttributedString(string: "COURSE".localized + (self.courseObj?.string(key: "coursename") ?? ""))
        attributedString.setColorForText((self.courseObj?.string(key: "coursename") ?? ""), with: UIColor(named: "#0961F5")!)
        courseLabel?.attributedText = attributedString
    }
    
    /// getSemesterList() used to call semester List API.
    /// - Parameter isShowloader: passing show loader boolean
    func getSemesterList(isShowloader: Bool = true){
        semesterListArray.removeAll()
        
        APIClient.sharedInstance.getSemestersListApi(courseId: courseObj?.string(key: "_id") ?? "", parameters: [:]) { responseObj in
            let listArray = responseObj?.array(key: "data") ?? []
            self.semesterListArray = listArray

            self.semesterCollectionView?.stopPullToRefresh()
            self.semesterCollectionViewDataSource.semesterListArray = self.semesterListArray
            self.semesterCollectionViewDataSource.courseObj = self.courseObj
            
        } failure: { error in
            self.semesterCollectionView?.stopPullToRefresh()
            makeToast(type: .error, title: APP_TITLE, message: error ?? "")
        }
    }
}

//MARK: - UISearchBarDelegate
extension SemesterListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            semesterCollectionViewDataSource.semesterListArray = semesterListArray
        } else {
            var filteredSemestersArray: [json] = []
            filteredSemestersArray = semesterListArray.filter({ (semesterObject) -> Bool in
                let semesterName: NSString = semesterObject.string(key: "semester") as NSString
                let range = semesterName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            semesterCollectionViewDataSource.semesterListArray = filteredSemestersArray
        }
        semesterCollectionView?.reloadData()
    }
}
