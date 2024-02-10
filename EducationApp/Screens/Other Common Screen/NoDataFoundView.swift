//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit

/// To used for no data found view when data is not available
class NoDataFoundView: UIView {
    
    //MARK: - IBOutlet Declaration
    
    /// noDataFoundTitleLabel is text label of title.
    @IBOutlet weak var noDataFoundTitleLabel : UILabel?
    
    /// noDataFoundDescriptionLabel is text label of description.
    @IBOutlet weak var noDataFoundDescriptionLabel : UILabel?
    
    /// noDataFoundImageView displays image of a empty data.
    @IBOutlet weak var noDataFoundImageView: UIImageView?
    
    /// noDataFoundBackgroundView is a background view of current NoDataFoundView.
    @IBOutlet weak var noDataFoundBackgroundView: UIView?
    
    /// imageBackgroundView is a background view of current NoDataFoundView.
    @IBOutlet weak var imageBackgroundView: UIView?
    
    /// titleBackgroundView is a background view of current NoDataFoundView.
    @IBOutlet weak var titleBackgroundView: UIView?
    
    /// descriptionBackgroundView is a background view of current NoDataFoundView.
    @IBOutlet weak var descriptionBackgroundView: UIView?

    //MARK: - view life cycle
    
    /// awake From Nib
    ///
    /// - Purpose : Called when nib loads.
    /// - Description : To set values after view awakes.
    override func awakeFromNib() {
        // Initialization code
    }
}
