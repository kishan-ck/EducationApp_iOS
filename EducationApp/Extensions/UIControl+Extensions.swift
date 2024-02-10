//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

//MARK: - UIControl setup
extension UIControl {
    
    /// Set click event to targated UIControl.
    /// - Parameter block: A type for action block closure.
    func block_setAction(block: @escaping BlockButtonActionBlock) {
        objc_setAssociatedObject(self, &ActionBlockKey, ActionBlockWrapper(block: block), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        addTarget(self, action: #selector(block_handleAction), for: .touchUpInside)
    }
    
    /// Action method for selector of targated UIControl.
    @objc func block_handleAction() {
        let wrapper = objc_getAssociatedObject(self, &ActionBlockKey) as! ActionBlockWrapper
        wrapper.block(self)
    }
}
