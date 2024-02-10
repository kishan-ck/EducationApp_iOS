//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit

/// UIBarButtonItemClosureWrapper Class
class UIBarButtonItemClosureWrapper: NSObject {
    let closure: UIBarButtonItemTargetClosure
    init(_ closure: @escaping UIBarButtonItemTargetClosure) {
        self.closure = closure
    }
}

/// ActionBlockWrapper Class
class ActionBlockWrapper : NSObject {
    var block : BlockButtonActionBlock
    init(block: @escaping BlockButtonActionBlock) {
        self.block = block
    }
}
