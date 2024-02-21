//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet Declaration
    @IBOutlet weak var titleImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    
    //MARK: - view life cycle
    
    /// awake From Nib
    ///
    /// - Purpose : Called when nib loads.
    /// - Description : To set values after view awakes.
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// Selection method of UITableViewCell.
    /// - Parameters:
    ///   - selected: whether UITableViewCell selected or not via didSelect method.
    ///   - animated: Animation on didSelect method.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
