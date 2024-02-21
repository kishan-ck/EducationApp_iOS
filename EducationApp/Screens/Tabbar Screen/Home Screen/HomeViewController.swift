//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

/// HomeViewController is used as dahsboard screen.
class HomeViewController: UIViewController {
    
    //MARK: - IBOutlet Declaration
    
    @IBOutlet weak var welcomeLabel: UILabel?
    
    @IBOutlet weak var advertisementCollectionView: UICollectionView?

    @IBOutlet weak var coursesView: UIView?
    @IBOutlet weak var coursesCollectionView: UICollectionView?
    
    @IBOutlet weak var facultiesView: UIView?
    @IBOutlet weak var facultiesCollectionView: UICollectionView?
    
    @IBOutlet weak var becomeAFacultyView: UIView?
    
    @IBOutlet weak var totalDataView: UIView?
    @IBOutlet weak var totalInstructorView: UIView?
    @IBOutlet weak var totalInstructorLabel: UILabel?
    
    @IBOutlet weak var totalSubjectsView: UIView?
    @IBOutlet weak var totalSubjectsLabel: UILabel?
    
    @IBOutlet weak var totalCoursesView: UIView?
    @IBOutlet weak var totalCoursesLabel: UILabel?
    
    @IBOutlet weak var happyStudentView: UIView?
    @IBOutlet weak var happyStudentLabel: UILabel?
    
    //MARK: - Variable Declaration
    var advertisementCollectionDataSource = AdvertisementCollectionDataSource()
    
    var coursesCollectionDataSource = CoursesCollectionDataSource()
    
    var facultiesCollectionDataSource = FacultiesCollectionDataSource()
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        advertisementCollectionView?.setDataSourceDelegate(datasourceAndDelegate: advertisementCollectionDataSource, collectionCell: "AdvertisementCollectionViewCell")
        
        coursesCollectionView?.setDataSourceDelegate(datasourceAndDelegate: coursesCollectionDataSource, collectionCell: "CoursesCollectionViewCell")
        
        facultiesCollectionView?.setDataSourceDelegate(datasourceAndDelegate: facultiesCollectionDataSource, collectionCell: "FacultiesCollectionViewCell")
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
extension HomeViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        self.navigationController?.navigationBar.isHidden = true
        
        welcomeLabel?.text = String(format: "HELLO_STUDENT".localized, Config().getUser().string(key: "firstName"), Config().getUser().string(key: "lastName"))
        
        [totalCoursesView, totalSubjectsView, totalInstructorView, happyStudentView].forEach { (view) in
            view?.layer.applySketchShadow(color: UIColor(named: "#000000")!, alpha: 0.10, x: 1, y: 2, blur: 10.0, spread: 0)
        }
    }
}

//MARK: - IBAction Method
extension HomeViewController {
    
    @IBAction func applyForFacultyButtonAction(_ sender: Any) {
    }
    
    @IBAction func coursesSeeAllButtonAction(_ sender: Any) {
    }
    
    @IBAction func facultiesSeeAllButtonAction(_ sender: Any) {
    }
}
