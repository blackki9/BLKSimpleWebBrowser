//
//  BLKEmptyStringValidator.swift
//  BLKTaskList
//
//  Created by black9 on 01/09/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

import UIKit

class BLKEmptyStringValidator: NSObject, BLKValidator {
   
    func isValid(validationString:String?) -> Bool {
        if let string = validationString {
            if !string.isEmpty {
                return true
            }
        }
        return false
    }
}
