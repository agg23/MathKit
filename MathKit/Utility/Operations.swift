//
//  Operations.swift
//  MathKit
//
//  Created by Adam Gastineau on 11/26/15.
//  Copyright © 2015 Adam Gastineau. All rights reserved.
//

import Foundation

class Operations {
    class func add(first: NSNumber, second: NSNumber) -> ResultToken {
        return ResultToken(decimal: first.doubleValue + second.doubleValue)
    }
    
    class func subtract(first: NSNumber, second: NSNumber) -> ResultToken {
        return ResultToken(decimal: first.doubleValue - second.doubleValue)
    }
    
    class func multiply(first: NSNumber, second: NSNumber) -> ResultToken {
        return ResultToken(decimal: first.doubleValue * second.doubleValue)
    }
    
    class func divide(first: NSNumber, second: NSNumber) -> ResultToken {
        return ResultToken(decimal: first.doubleValue / second.doubleValue)
    }
}