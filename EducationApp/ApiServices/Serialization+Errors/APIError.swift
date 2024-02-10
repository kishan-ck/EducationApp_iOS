//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit

#if DEBUG
func dLog(message: Any, filename: String = #file, function: String = #function, line: Int = #line) {
    NSLog("%@","[\((filename as NSString).lastPathComponent):\(line)] \(function) - \(message)")
}
#else
func dLog(message: Any, filename: String = #file, function: String = #function, line: Int = #line) {
}
#endif

/// Displays Error message provided from API.
/// - Parameter errors: number of errors to display via toast message.
func displayErrorMessage(errors: json){
    
    if let keys = errors.dictionaryObject?.keys {
        var errorArray: [String] = [String]()
        for key in keys {
            let array = errors.array(key: key)
            if array.count > 0 {
                errorArray.append(array.first?.rawValue as? String ?? "")
            }
            if errorArray.count > 0 {
                makeToast(type: .error, title: APP_TITLE, message: errorArray.joined(separator: ", "))
                return
            }
        }
    }
}
