//
//  Expression.swift
//  MathKit
//
//  Created by Adam Gastineau on 11/25/15.
//  Copyright © 2015 Adam Gastineau. All rights reserved.
//

import Foundation

class Expression: NSObject {
    var postfixTokens: Array<Token>
    var variables: Array<Token>
    
    init(tokens: Array<Token>, variables: Array<Token>?) {
        self.postfixTokens = tokens
        if variables != nil {
            self.variables = variables!
        } else {
            self.variables = Array<Token>()
        }
    }
}
