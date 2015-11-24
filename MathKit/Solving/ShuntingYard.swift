//
//  ShuntingYard.swift
//  MathKit
//
//  Created by Adam Gastineau on 11/24/15.
//  Copyright © 2015 Adam Gastineau. All rights reserved.
//

import Foundation

class ShuntingYard: NSObject {
    var outputQueue = Queue<Double>()
    var functionStack = Stack<String>()
    
    func parseString(string:String) {
        // Tokenize
    }
}