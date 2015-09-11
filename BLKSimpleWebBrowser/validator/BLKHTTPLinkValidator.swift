//
//  BLKHTTPLinkValidator.swift
//  BLKSimpleWebBrowser
//
//  Created by black9 on 07/09/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

import UIKit

class BLKHTTPLinkValidator: NSObject, BLKValidator {
   
    let emptyStringValidator = BLKEmptyStringValidator()
    
    func isValid(validationString: String?) -> Bool {
        if !emptyStringValidator.isValid(validationString) {
            return false
        }
        
        if let string = validationString, let url = NSURL(string: string) {
            return true
        }
        
        return false
    }
}
