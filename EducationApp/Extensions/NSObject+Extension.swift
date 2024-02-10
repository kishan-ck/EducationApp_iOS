//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit

/// object that handles UICollectionView to return the value associated with a given object for a given key.
private var AssociatedObjectHandle: UInt8 = 0

/// object that handles UITableView to return the value associated with a given object for a given key.
var TableObejctHandel = "TABLEVIEWHANDAL"

//MARK: - NSObject Setup

extension NSObject {
    
    var CollectionView: UICollectionView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? UICollectionView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var TableView: UITableView? {
        get {
            return objc_getAssociatedObject(self, &TableObejctHandel) as? UITableView
        }
        set {
            objc_setAssociatedObject(self, &TableObejctHandel, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
