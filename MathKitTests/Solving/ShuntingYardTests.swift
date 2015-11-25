//
//  ShuntingYardTests.swift
//  MathKit
//
//  Created by Adam Gastineau on 11/24/15.
//  Copyright © 2015 Adam Gastineau. All rights reserved.
//

import XCTest
@testable import MathKit

class ShuntingYardTests: XCTestCase {

    func testBasicShuntingYard() {
        let shuntingYard = ShuntingYard()
        
        shuntingYard.parseString("4 + 5 + (6-7)")
        
        while !shuntingYard.outputQueue.isEmpty() {
            print(shuntingYard.outputQueue.dequeue()?.value)
        }
    }
}
