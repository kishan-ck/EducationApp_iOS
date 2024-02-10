//
// Copyright (c) 2024 Education App All rights reserved.
//

import Foundation

extension Double {
    
    /// Rounds the double to decimal places value
    func roundedValue(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
