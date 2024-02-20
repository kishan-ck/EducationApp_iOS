//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class SemesterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var semesterImageView: UIImageView?
    @IBOutlet weak var semesterTitleLabel: UILabel?
    @IBOutlet weak var semesterDescriptionLabel: UILabel?
    @IBOutlet weak var backView: UIView?
    
    //MARK: - view life cycle
    
    /// awake From Nib
    ///
    /// - Purpose : Called when nib loads.
    /// - Description : To set values after view awakes.
    override func awakeFromNib() {
        super.awakeFromNib()
        backView?.layer.applySketchShadow(color: UIColor(named: "#000000")!, alpha: 0.10, x: 1, y: 2, blur: 10.0, spread: 0)
    }
}
