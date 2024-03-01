//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class CoursesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView?
    @IBOutlet weak var isLikeButton: UIButton?
    @IBOutlet weak var isLikeImageView: UIImageView?
    @IBOutlet weak var semesterLabel: UILabel?
    @IBOutlet weak var subjectNameLabel: UILabel?
    @IBOutlet weak var courseNameLabel: UILabel?
    @IBOutlet weak var titleImageView: UIImageView?
    
    @IBOutlet weak var isLikeImageBackView: UIView?
    @IBOutlet weak var subjectNameLabelView: UIView?
    @IBOutlet weak var semesterLabelView: UIView?
    
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
