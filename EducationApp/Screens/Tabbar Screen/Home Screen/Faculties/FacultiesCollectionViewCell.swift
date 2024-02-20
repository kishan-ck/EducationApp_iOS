//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class FacultiesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var facultieFieldLabel: UILabel?
    @IBOutlet weak var facultieNameLabel: UILabel?
    @IBOutlet weak var facultieImageView: UIImageView?
    
    //MARK: - view life cycle
    
    /// awake From Nib
    ///
    /// - Purpose : Called when nib loads.
    /// - Description : To set values after view awakes.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
