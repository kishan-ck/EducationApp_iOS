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
        
        getHomeDataApi()
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
        
        welcomeLabel?.text = String(format: "%@ %@ %@", "WELCOME_TEXT".localized, Config().getUser().string(key: "firstName"), Config().getUser().string(key: "lastName"))
        
        [totalCoursesView, totalSubjectsView, totalInstructorView, happyStudentView].forEach { (view) in
            view?.layer.applySketchShadow(color: UIColor(named: "#000000")!, alpha: 0.10, x: 1, y: 2, blur: 10.0, spread: 0)
        }
    }
    
    /// getHomeDataApi() used to call home List API.
    func getHomeDataApi(){
        let collegeId = Config().getUser().object(key: "student_course_details").object(key: "college_details").string(key: "_id")
        APIClient.sharedInstance.getAllHomeDataApi(collegeId: collegeId, parameters: [:]) { responseObj in
            let listObject = responseObj?.object(key: "data")
            
            let collegeTotals = responseObj?.object(key: "collegeTotals")
            self.totalInstructorLabel?.text = "\(collegeTotals?.integer(key: "totalInstructor") ?? 0)"
            self.totalCoursesLabel?.text = "\(collegeTotals?.integer(key: "totalCourse") ?? 0)"
            self.totalSubjectsLabel?.text = "\(collegeTotals?.integer(key: "totalSubject") ?? 0)"
            self.happyStudentLabel?.text = "\(collegeTotals?.integer(key: "totalStudents") ?? 0)"

            self.advertisementCollectionDataSource.advertisementArray = listObject?.array(key: "advertisements") ?? [[:]]
            self.coursesCollectionDataSource.coursesArray = listObject?.array(key: "popularCourses") ?? [[:]]
            self.facultiesCollectionDataSource.facultiesArray = listObject?.array(key: "faculties") ?? [[:]]
        } failure: { error in
            makeToast(type: .error, title: APP_TITLE, message: error ?? "")
        }
    }
}

//MARK: - IBAction Method
extension HomeViewController {
    
    @IBAction func applyForFacultyButtonAction(_ sender: Any) {
    }
    
    @IBAction func coursesSeeAllButtonAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func facultiesSeeAllButtonAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
    }
}
