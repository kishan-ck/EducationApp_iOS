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
        
        facultieProfesionLabel?.text = "Swift Developer"
        facultieNameLabel?.text = "Dhruv Jariwala"
        
        degreeLabel?.text = "B.E(CSE)"
        personalInformationProfesionLabel?.text = "Swift Developer"
        
        emailLabel?.text = "dhruv.coderkube@gmail.com"
        experienceLabel?.text = "3"
        
        awardsLabel?.text = "સિંહને કોઈ એવોર્ડની જરૂર નથી"
    }
}
