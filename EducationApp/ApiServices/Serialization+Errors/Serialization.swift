//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import SwiftyJSON

/// Converts String Array to Data.
/// - Parameter stringArray: Array of String
/// - Returns: returns Data
func stringArrayToData(stringArray: [String]) -> Data? {
    return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
}

/// Converts Int Array to Data.
/// - Parameter intArray: Array of Int
/// - Returns: returns Data
func intArrayToData(intArray: [Int]) -> Data? {
    return try? JSONSerialization.data(withJSONObject: intArray, options: [])
}

/// Converts String Dictionary to Data.
/// - Parameter dic: key value JSONDictionary of String
/// - Returns: returns Data
func stringDicToData(dic: JSONDictionary) -> Data? {
    return try? JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
}

/// Converts JSON Array to Data.
/// - Parameter dic: Json Array with key value pairs.
/// - Returns: returns Data
func jsonArrayToData(stringArray: [String]) -> Data? {
    return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
}

//MARK: - Decodable setup
extension Decodable {
    
    init(from: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}

//MARK: - JSON setup
extension JSON {
    
    /// Gets Int value from from JSON
    /// - Parameter key: name of key in String
    /// - Returns: returns SwiftyJson IntValue
    func integer(key: String) -> Int {
        return self[key].intValue
    }
    
    /// Gets String value from from JSON
    /// - Parameter key: name of key in String
    /// - Returns: returns SwiftyJson stringValue
    func string(key: String) -> String {
        return self[key].stringValue
    }
    
    /// Gets Double value from from JSON
    /// - Parameter key: name of key in String
    /// - Returns: returns SwiftyJson doubleValue
    func double(key: String) -> Double {
        return self[key].doubleValue
    }
    
    /// Gets array from JSON
    /// - Parameter key: name of key in String
    /// - Returns: returns SwiftyJson arrayValue
    func array(key: String) -> [JSON] {
        return self[key].arrayValue
    }
    
    /// Gets JSON object from JSON
    /// - Parameter key: name of key in String
    /// - Returns: returns SwiftyJson dictionaryValue
    func object(key: String) -> JSON{
        return JSON(rawValue: self[key].dictionaryValue) ?? [:]
    }
}
