//
//  BLKValidator.swift
//  BLKTaskList
//
//  Created by black9 on 01/09/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

import Foundation

protocol BLKValidator {
    func isValid(validationString:String?) -> Bool
}