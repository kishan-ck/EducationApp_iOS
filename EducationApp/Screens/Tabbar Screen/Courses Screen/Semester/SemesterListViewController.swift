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
    let temp: String = "B.E"
    var semesterCollectionViewDataSource = SemesterCollectionViewDataSource()
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        semesterCollectionView?.setDataSourceDelegate(datasourceAndDelegate: semesterCollectionViewDataSource, collectionCell: "SemesterCollectionViewCell")
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
        
        let attributedString = NSMutableAttributedString(string: "COURSE".localized + temp)
        attributedString.setColorForText(temp, with: UIColor(named: "#0961F5")!)
        courseLabel?.attributedText = attributedString
    }
}

//MARK: - UISearchBarDelegate
extension SemesterListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            
        } else {
            
        }
        semesterCollectionView?.reloadData()
    }
}
