//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

/// WelcomeViewDelegate Delegate
protocol WelcomeViewDelegate {
    func collectionViewIndexPath(pageIndex: Int)
}

class WelcomeViewController: UIViewController {

    @IBOutlet weak var firstIntroductionView: UIView?
    @IBOutlet weak var secondIntroductionView: UIView?
    @IBOutlet weak var thirdIntroductionView: UIView?
    
    @IBOutlet weak var introductionCollectionView: UICollectionView?
    
    //MARK: - Variable Declaration
    
    /// welcomeCollectionDataSource is an instance for WelcomeCollectionDataSource.
    var welcomeCollectionDataSource = WelcomeCollectionDataSource()
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeCollectionDataSource.welcomeViewDelegate = self
        introductionCollectionView?.setDataSourceDelegate(datasourceAndDelegate: welcomeCollectionDataSource, collectionCell: "WelcomeCollectionViewCell")
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
extension WelcomeViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
}

//MARK: - WelcomeViewController Delegate
extension WelcomeViewController: WelcomeViewDelegate {
    
    func collectionViewIndexPath(pageIndex: Int) {
        if pageIndex == 0 {
            firstIntroductionView?.isHidden = false
            secondIntroductionView?.isHidden = true
            thirdIntroductionView?.isHidden = true
            
        } else if pageIndex == 1 {
            firstIntroductionView?.isHidden = true
            secondIntroductionView?.isHidden = false
            thirdIntroductionView?.isHidden = true
            
        } else if pageIndex == 2 {
            firstIntroductionView?.isHidden = true
            secondIntroductionView?.isHidden = true
            thirdIntroductionView?.isHidden = false
        }
    }
}
