//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import Alamofire

/// BaseViewController is a common Background image used in every UIViewCotroller.
class BaseImageViewController: BaseViewController {
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

/// BaseViewController is a common Tab bar and Modification used in every UIViewCotroller.
class BaseViewController: UIViewController {
    
    //MARK: - Class Method
    
    /// View did load
    ///
    /// - Purpose : Called when view did load
    /// - Description : To set values after view did load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// View will appeare
    ///
    /// - Parameter animated: passing true or false
    /// - Purpose : Called when view will appear
    /// - Description : To hide navigation bar after view will appear
    /// - Error : -
    /// - Dependency : -
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /// Set up transparent navigation bar with custom back button and feedack button
    /// - Parameters:
    ///   - isShowBackButton: passing show back button boolean flag.
    ///   - showTitle: passing show title string.
    func navigationBarWithRightButtonTransparent(isShowBackButton: Bool, showTitle: String? = "") {
        // set up navigation bar
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isHidden = false
        
        // set up back button
        if isShowBackButton {
            let backButton = UIButton()
            
            switch self {
            case is LoginViewController:
                backButton.setImage(UIImage(named: "ic_darkback")?.imageFlippedForRightToLeftLayoutDirection(), for: .normal)
                break
            default:
                backButton.setImage(UIImage(named: "ic_back")?.imageFlippedForRightToLeftLayoutDirection(), for: .normal)
                break
            }
            
    
            backButton.addTarget(self, action: #selector(self.backButtonAction(sender:)), for: .touchUpInside)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.navigationItem.title = showTitle
            self.view.backgroundColor = UIColor(named: "#F2F2F2 - #000D1C")
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: themeFont(size: 20, fontname: .poppinsBold), NSAttributedString.Key.foregroundColor: UIColor(named: "TextColor - #252A36") as Any]
        }
    }
    
    /*/// Click event for back button
    @objc func backButtonAction() {
        self.dismiss(animated: false, completion: nil)
        if let stack = self.navigationController?.viewControllers, stack.count > 1 {
            self.navigationController?.popViewController(animated: true)
        }
    }*/
    
    /// To used for back button event.
    ///
    /// - Parameter sender: passing sender object.
    @IBAction func backButtonAction(sender : UIButton){
        self.dismiss(animated: false, completion: nil)
        if let stack = self.navigationController?.viewControllers, stack.count > 1 {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /// Set navigation bar right button.
    ///
    /// - Parameters:
    ///   - titleString: passing title string
    ///   - titleColor: passing title color
    ///   - backgroundColor: passing background color
    ///   - titleFont: passing title font
    ///   - width: passing button width
    ///   - height: passing button height
    ///   - cornerRadius: passing corner radius of button
    /// - Purpose : Called to set right navigation button.
    /// - Description : Call to set right navigation button.
    /// - Error : -
    /// - Dependency : -
    func setRightMenuButton(titleString: String, titleColor: UIColor? = UIColor(named: "WhiteColor - #FFFFFF"), backgroundColor: UIColor? = UIColor(named: "FloatingYellow - #E3A130"), titleFont: UIFont? = themeFont(size: 15, fontname: .poppinsRegular), width: CGFloat, height: CGFloat, cornerRadius: CGFloat) {
        let setRightMenuButton = UIButton(type: .custom)
        setRightMenuButton.setTitle(titleString.localized, for: .normal)
        setRightMenuButton.titleLabel?.font = titleFont
        setRightMenuButton.titleLabel?.textAlignment = .center
        
        setRightMenuButton.setTitleColor(titleColor, for: .normal)
        setRightMenuButton.backgroundColor = backgroundColor
        
        setRightMenuButton.cornerRadius = cornerRadius
        setRightMenuButton.clipsToBounds = true
        setRightMenuButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        setRightMenuButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        setRightMenuButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        setRightMenuButton.addTarget(self, action: #selector(self.btnSetRightMenuButtonFired(sender:)), for: .touchUpInside)
        let rightBarBtnItem = UIBarButtonItem(customView: setRightMenuButton)
        self.navigationItem.rightBarButtonItem = rightBarBtnItem
    }
    
    /// Navigation right click event.
    ///
    /// - Parameter sender: passing sender object.
    /// - Purpose : Called when right navigation button is pressed.
    /// - Description : Call to perfrom action.
    /// - Error : -
    /// - Dependency : -
    @IBAction func btnSetRightMenuButtonFired(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Set flow layout to collection view object
    ///
    /// - Parameter collectionViewObject: passing collection view object
    func setFlowLayoutToCollectionView(collectionViewObject : UICollectionView){
        //let layout = TagFlowLayout()
        //layout.estimatedItemSize = CGSize(width: 140, height: 40)
        //collectionViewObject.collectionViewLayout = layout
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .center)
        layout.minimumInteritemSpacing = widthPer(per: 2.32)
        layout.minimumLineSpacing = widthPer(per: 2.32)
        collectionViewObject.collectionViewLayout = layout
    }
    
    /// To used for application status bar default style.
    func applicationStatusBarDefaultStyle(){
        UIApplication.shared.statusBarStyle = .default
    }
    
    /// To used for applicatin status bar light content style.
    func applicationStatusBarLightContentStyle(){
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
