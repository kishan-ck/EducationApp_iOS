//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation

//MARK: - Date setup
extension Date {
    
    
    /// Formats date in given textual representations.
    /// - Returns: returns date in MM/dd/yyyy format
    static func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }
}
