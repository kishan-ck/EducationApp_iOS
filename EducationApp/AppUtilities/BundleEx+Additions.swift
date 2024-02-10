//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation

public var kBundleKey: UInt8 = 0

/// BundleEx Class
class BundleEx: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = objc_getAssociatedObject(self, &kBundleKey) {
            return (bundle as! Bundle).localizedString(forKey: key, value: value, table: tableName)
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}
