//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

/// NoInternetConnectionViewController is used if user internet connection is off.
class NoInternetConnectionViewController: BaseImageViewController {
    
    //MARK: - IBOutlet Declaration
    
    /// Indicates you are offline of user, that user internet connection is off.
    @IBOutlet weak var offlineLabel: UILabel?

    /// To used for retry button
    @IBOutlet weak var retryButton: UIButton?
    
    //MARK: - Variable Declaration
    
    /// To used for reload call back method
    var reloadCallBack: (() -> Void)?
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

//MARK: - UI Functions
extension NoInternetConnectionViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
    }
}

//MARK: - IBAction Method
extension NoInternetConnectionViewController {
    
    /// reloadButtonAction UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : This will check internet connection is on or off.
    @IBAction func retryButtonAction(_ sender: Any) {
        print("Need to check internet connection.")
        reloadCallBack!()
    }
}
