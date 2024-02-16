//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

/// LoginSuccessPopUpViewController is used when user login successfully.
class LoginSuccessPopUpViewController: BaseViewController {
    
    //MARK: - IBOutlet Declaration
    @IBOutlet weak var backView: UIView?
    
    //MARK: - Variable Declaration
    var completion: stringCompletionHandler?
    
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
extension LoginSuccessPopUpViewController {
    
    /// setupUI() function will be used for the setup ui when view contoller will load.
    func setUpUI() {
        backView?.bottomRoundView()
    }
}

//MARK: - IBAction Method
extension LoginSuccessPopUpViewController {
    
    /// doneButton UIButton click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Description : It is used to redirect to home screen.
    @IBAction func doneButtonAction(_ sender: Any) {
        guard let completionBlock = self.completion else {
            return
        }
        completionBlock("test")
        dismiss(animated: false, completion: nil)
    }
}
