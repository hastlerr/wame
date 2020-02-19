//
//  String+Helper.swift
//  WAME
//
//  Created by Avaz Abdrasulov on 2/16/20.
//  Copyright © 2020 HASL LLC. All rights reserved.
//

import Foundation

extension String {
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func digitsOnly() -> String{
        let allowedCharset = CharacterSet
            .decimalDigits
            .union(CharacterSet(charactersIn: "+"))
        
        return String(self.unicodeScalars.filter(allowedCharset.contains))
    }
    
}
