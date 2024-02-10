//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation

//MARK: - Dictionary setup
extension Dictionary {
    
    /// Convert dictionary to json string
    ///
    /// - Returns: return value description
    func convertToJSonString() -> String {
        do {
            let dataJSon = try JSONSerialization.data(withJSONObject: self as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted)
            let st: NSString = NSString.init(data: dataJSon, encoding: String.Encoding.utf8.rawValue)!
            return st as String
        } catch let error as NSError { print(error) }
        return ""
    }
    
    /// Check given key have value or not
    ///
    /// - Parameter stKey: pass key what you want check
    /// - Returns: true if exist
    func isKeyNull(_ stKey: String) -> Bool {
        let dict: JSONDictionary = (self as AnyObject) as! JSONDictionary
        if let val = dict[stKey] { return val is NSNull ? true : false }
        return true
    }
    
    /// Handle carsh when null valu or key not found
    ///
    /// - Parameter stKey: pass the key of object
    /// - Returns: blank string or value if exist
    func valueForKeyString(_ stKey: String) -> String {
        let dict: JSONDictionary = (self as AnyObject) as! JSONDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                return ""
            }else if (val as? NSNumber) != nil {
                return  val.stringValue
                
            }else if (val as? String) != nil {
                return val as! String
            }else{
                return ""
            }
        }
        return ""
    }
    
    /// Expaned function of null value
    func valueForKeyString(_ stKey: String,nullvalue:String) -> String {
        return  self.valueForKeyWithNullString(Key: stKey, NullReplaceValue: nullvalue)
    }
    
    /// Update dic with other Dictionary
    ///
    /// - Parameter other: add second Dictionary which one you want to add
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
    
    /// Use to get value for if key not found or null then replace with the string
    ///
    /// - Parameters:
    ///   - stKey: pass key of dic
    ///   - NullReplaceValue: set value what you want retun if that key is nill
    /// - Returns: retun key value if exist or return null replace value
    func valueForKeyWithNullString(Key stKey: String,NullReplaceValue:String) -> String {
        let dict: JSONDictionary = (self as AnyObject) as! JSONDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                return NullReplaceValue
            } else{
                if (val as? NSNumber) != nil {
                    return  val.stringValue
                }else{
                    return val as! String == "" ? NullReplaceValue : val as! String
                }
            }
        }
        return NullReplaceValue
    }
    
    func valuForKeyWithNullWithPlaseString(Key stKey: String,NullReplaceValue:String) -> String {
        let dict: JSONDictionary = (self as AnyObject) as! JSONDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                return NullReplaceValue
            } else{
                if (val as? NSNumber) != nil {
                    if Int(truncating: val as! NSNumber) > 0{
                        return  "+" + val.stringValue
                    }
                }else{
                    if Int(val as! String) ?? 0 > 0{
                        return val as! String == "" ? NullReplaceValue : "+" + (val as! String)
                    }else{
                        return val as! String == "" ? NullReplaceValue : val as! String
                    }
                }
            }
        }
        return NullReplaceValue
    }
    
    /// To value for key Array
    /// - Parameter stKey: passing string value.
    func valuForKeyArray(_ stKey: String) -> Array<Any> {
        let dict: JSONDictionary = (self as AnyObject) as! JSONDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                return []
            } else if val is NSArray{
                return val as! Array<Any>
            } else if val is String{
                return [val] as Array<Any>
            }else {
                return val as! Array<Any>
            }
        }
        return []
    }
    
    /// To value for key dictionary
    /// - Parameter stKey: passing string value.
    func valuForKeyDic(_ stKey: String) -> JSONDictionary {
        let dict: JSONDictionary = (self as AnyObject) as! JSONDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                return JSONDictionary()
            } else if ((val as? JSONDictionary) != nil){
                return val as! JSONDictionary
            }
        }
        return JSONDictionary()
    }
    
    /// This is function for convert dicticonery to xml string also check log for other type of string i only handal 2 or 3 type of stct
    ///
    /// - Returns: return xml string
    func createXML()-> String{
        var xml = ""
        for k in self.keys {
            
            if let str = self[k] as? String{
                xml.append("<\(k as! String)>")
                xml.append(str)
                xml.append("</\(k as! String)>")
                
            }else if let dic =  self[k] as? Dictionary{
                xml.append("<\(k as! String)>")
                xml.append(dic.createXML())
                xml.append("</\(k as! String)>")
                
            }else if let array : NSArray =  self[k] as? NSArray{
                for i in 0..<array.count {
                    xml.append("<\(k as! String)>")
                    if let dic =  array[i] as? Dictionary{
                        xml.append(dic.createXML())
                    }else if let str = array[i]  as? String{
                        xml.append(str)
                    }else{
                        fatalError("[XML]  associated with \(self[k] as Any) not any type!")
                    }
                    xml.append("</\(k as! String)>")
                    
                }
            }else if let dic =  self[k] as? NSDictionary{
                xml.append("<\(k as! String)>")
                
                let newdic = dic as! Dictionary<String,Any>
                xml.append(newdic.createXML())
                xml.append("</\(k as! String)>")
                
            }
            else{
                fatalError("[XML]  associated with \(self[k] as Any) not any type!")
            }
        }
        
        return xml
    }
    
    /// To value for key Int.
    /// - Parameter stKey: passing string value.
    func valueForKeyInt( _ any:String) -> Int {
        return valueForKeyInt(any,nullValue: 0)
    }
    
    /// To value for key Int with null value checking.
    /// - Parameter stKey: passing string value.
    func valueForKeyInt( _ any:String,nullValue :Int) -> Int {
        var iValue: Int = 0
        let dict: JSONDictionary = self as! JSONDictionary
        if let val = dict[any] {
            if val is NSNull {
                return 0
            }
            else {
                if val is Int {
                    iValue = val as! Int
                }
                else if val is Double {
                    iValue = Int(val as! Double)
                }
                else if val is String {
                    let stValue: String = val as! String
                    iValue = (stValue as NSString).integerValue
                }
                else if val is Float {
                    iValue = Int(val as! Float)
                }else{
                    let error = NSError(domain:any,
                                        code: 100,
                                        userInfo:dict)
                }
            }
        }
        return iValue
    }
    
    
    /// removes null key and provides default value.
    /// - Returns: [AnyHashable: Any]
    func nullKeyRemoval() -> [AnyHashable: Any] {
        var dict: [AnyHashable: Any] = self
        
        let keysToRemove = dict.keys.filter { dict[$0] is NSNull }
        let keysToCheck = dict.keys.filter({ dict[$0] is Dictionary })
        let keysToArrayCheck = dict.keys.filter({ dict[$0] is [Any] })
        for key in keysToRemove {
            dict.removeValue(forKey: key)
        }
        for key in keysToCheck {
            if let valueDict = dict[key] as? [AnyHashable: Any] {
                dict.updateValue(valueDict.nullKeyRemoval(), forKey: key)
            }
        }
        for key in keysToArrayCheck {
            if var arrayDict = dict[key] as? [Any] {
                for i in  0..<arrayDict.count {
                    if let dictObj = arrayDict[i] as? JSONDictionary {
                        arrayDict[i] = dictObj.nullKeyRemoval()
                    }
                }
                dict.updateValue(arrayDict, forKey: key)
            }
        }
        return dict
    }
}
