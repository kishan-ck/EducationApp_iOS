//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class WelcomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var getStartedButton: UIButton?
    
    @IBOutlet weak var buttonBackgroundView: UIView?
    
    @IBOutlet weak var descriptionLabel: UILabel?
    
    @IBOutlet weak var titleLabel: UILabel?
    
    @IBOutlet weak var topImageView: UIImageView?
    
    //MARK: - view life cycle
    
    /// awake From Nib
    ///
    /// - Purpose : Called when nib loads.
    /// - Description : To set values after view awakes.
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
