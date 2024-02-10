//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation

public var kBundleUIKitKey: UInt8 = 0

/// BundleUIKitEx Class
class BundleUIKitEx: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = objc_getAssociatedObject(self, &kBundleUIKitKey) {
            return (bundle as! Bundle).localizedString(forKey: key, value: value, table: tableName)
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}
