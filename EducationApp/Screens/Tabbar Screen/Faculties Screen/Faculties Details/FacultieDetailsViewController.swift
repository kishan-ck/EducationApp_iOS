//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

class FacultieDetailsViewController: BaseViewController {
    
    //MARK: - IBOutlet Declaration
    
    //Top Data
    @IBOutlet weak var facultieProfileImageView: UIImageView?
    @IBOutlet weak var facultieNameLabel: UILabel?
    @IBOutlet weak var facultieProfesionLabel: UILabel?
    
    //Personal Information Data
    @IBOutlet weak var personalInformationView: UIView?
    
    @IBOutlet weak var personalInformationDegreeView: UIView?
    @IBOutlet weak var degreeLabel: UILabel?
    
    @IBOutlet weak var personalInformationProfessionView: UIView?
    @IBOutlet weak var personalInformationProfesionLabel: UILabel?
    @IBOutlet weak var personalInformationWorkPlaceLabel: UILabel?
    
    @IBOutlet weak var personalInformationEmailView: UIView?
    @IBOutlet weak var emailLabel: UILabel?
    
    @IBOutlet weak var personalInformationExperienceView: UIView?
    @IBOutlet weak var experienceLabel: UILabel?
    
    //Achievement/Awards Data
    @IBOutlet weak var awardsView: UIView?
    @IBOutlet weak var awardsLabel: UILabel?
    
    //MARK: - Variable Declaration
    
    var facultiesObj: json?
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
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
extension FacultieDetailsViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        navigationBarWithRightButtonTransparent(isShowBackButton: true, showTitle: "FACULTY_DETAILS".localized, isShowSearchButton: false)
        
        facultieProfileImageView?.getImage(url: facultiesObj?.string(key: "profileImage") ?? "", placeHolderImage: enumForPlaceHolderImage.commonCoursesBackgroundImage.rawValue)
        facultieProfesionLabel?.text = (facultiesObj?.string(key: "lecture") ?? "")
        
        degreeLabel?.text = (facultiesObj?.string(key: "degree") ?? "BCA")
        
        personalInformationProfesionLabel?.text = (facultiesObj?.string(key: "lecture") ?? "")
        personalInformationWorkPlaceLabel?.text = (facultiesObj?.object(key: "college_Details").string(key: "collegeName"))
        
        facultieNameLabel?.text = (facultiesObj?.string(key: "name") ?? "")
        emailLabel?.text = (facultiesObj?.string(key: "email") ?? "")
        experienceLabel?.text = (facultiesObj?.string(key: "experience") ?? "")
        
        awardsLabel?.text = (facultiesObj?.string(key: "facultyDetail") ?? "")
    }
}
