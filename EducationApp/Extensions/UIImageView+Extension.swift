//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import SDWebImage

/// Enum for place holder images
enum enumForPlaceHolderImage: String {
    
    case profileImage = "ic_user_profile_image"
    case profileBannerImage = "ic_profile_banner"
    case commonBannerImage = "ic_common_banner"
    case defaultImage = "app_logo"
}

//MARK: - UIImageView setup
extension UIImageView{
    
    /// Updates height of an UIImage with Identifier.
    public func updateHeight() {
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
            
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            self.selfconstraintWithIdentifier("ImageHeight")?.constant = scaledHeight-1
        }
    }
    
    /// Updates height of an UIImage with Identifier.
    public func updateHeight(newvalue : UIImage) -> CGFloat {
        let myImageWidth = newvalue.size.width
        let myImageHeight = newvalue.size.height
        let myViewWidth = self.frame.size.width
        
        let ratio = myViewWidth/myImageWidth
        let scaledHeight = myImageHeight * ratio
        self.selfconstraintWithIdentifier("ImageHeight")?.constant = scaledHeight-1
        return scaledHeight-1
    }
    
    
    /// Gets UIImage from URL.
    /// - Parameter url: web url of image.
    func getImage(url: String, placeHolderImage: String = enumForPlaceHolderImage.profileImage.rawValue, backgroundColor: UIColor = UIColor(named: "WhiteColor - #FFFFFF")!) {
        //if url != "" {
            self.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.sd_setImage(with: URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""), placeholderImage: UIImage(named: placeHolderImage), options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
                if error == nil {
                    self.image = image
                    self.updateHeight()
                    self.backgroundColor = backgroundColor
                } else {
                    print("Image not found from the URL.")
                }
            })
        //}
    }
    
    /// set tint color of UIImage.
    /// - Parameter color: UIColor.white
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
