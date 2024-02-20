//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class FacultiesTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet Declaration
    @IBOutlet weak var backView: UIView?
    @IBOutlet weak var facultieImageView: UIImageView?
    
    @IBOutlet weak var facultieNameLabelView: UIView?
    @IBOutlet weak var facultieNameLabel: UILabel?
    
    @IBOutlet weak var facultieDegreeLabelView: UIView?
    @IBOutlet weak var facultieDegreeLabel: UILabel?
    
    @IBOutlet weak var facultieEmailLabelView: UIView?
    @IBOutlet weak var facultieEmailLabel: UILabel?
    
    @IBOutlet weak var facultieExperienceLabelView: UIView?
    @IBOutlet weak var facultieExperienceLabel: UILabel?
    
    //MARK: - view life cycle
    
    /// awake From Nib
    ///
    /// - Purpose : Called when nib loads.
    /// - Description : To set values after view awakes.
    override func awakeFromNib() {
        super.awakeFromNib()
        backView?.layer.applySketchShadow(color: UIColor(named: "#000000")!, alpha: 0.10, x: 1, y: 2, blur: 10.0, spread: 0)
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
