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
        
        let array = shuntingYard.buildPostfixExpressionFromString("4 + 5 + (6-7)").postfixTokens
        
        XCTAssertEqual(array[0].value as? NSNumber, 4)
        XCTAssertEqual(array[1].value as? NSNumber, 5)
        XCTAssertEqual(array[2].value as? String, "+")
        XCTAssertEqual(array[3].value as? NSNumber, 6)
        XCTAssertEqual(array[4].value as? NSNumber, 7)
        XCTAssertEqual(array[5].value as? String, "-")
        XCTAssertEqual(array[6].value as? String, "+")
    }
    
    func testLongerShuntingYard() {
        let shuntingYard = ShuntingYard()
        
        let array = shuntingYard.buildPostfixExpressionFromString("4 + 5 + (6-7) * 2 + (23-4)").postfixTokens
        
        XCTAssertEqual(array[0].value as? NSNumber, 4)
        XCTAssertEqual(array[1].value as? NSNumber, 5)
        XCTAssertEqual(array[2].value as? String, "+")
        XCTAssertEqual(array[3].value as? NSNumber, 6)
        XCTAssertEqual(array[4].value as? NSNumber, 7)
        XCTAssertEqual(array[5].value as? String, "-")
        XCTAssertEqual(array[6].value as? NSNumber, 2)
        XCTAssertEqual(array[7].value as? String, "*")
        XCTAssertEqual(array[8].value as? String, "+")
        XCTAssertEqual(array[9].value as? NSNumber, 23)
        XCTAssertEqual(array[10].value as? NSNumber, 4)
        XCTAssertEqual(array[11].value as? String, "-")
        XCTAssertEqual(array[12].value as? String, "+")
    }
    
    func testRightAssociativeShuntingYard() {
        let shuntingYard = ShuntingYard()
        
        let array = shuntingYard.buildPostfixExpressionFromString("4 ^ (3 + 2) * 3").postfixTokens
        
        XCTAssertEqual(array[0].value as? NSNumber, 4)
        XCTAssertEqual(array[1].value as? NSNumber, 3)
        XCTAssertEqual(array[2].value as? NSNumber, 2)
        XCTAssertEqual(array[3].value as? String, "+")
        XCTAssertEqual(array[4].value as? String, "^")
        XCTAssertEqual(array[5].value as? NSNumber, 3)
        XCTAssertEqual(array[6].value as? String, "*")
    }
    
    //MARK: Evaluator Tests
    
    func testBasicEvaluator() {
        let shuntingYard = ShuntingYard()
        
        let expression = shuntingYard.buildPostfixExpressionFromString("4 + 5 + (6-7)")
        
        let result = shuntingYard.evaluateExpression(expression)
        
        XCTAssertEqual((result!.value as! NSNumber).doubleValue, 8)
    }
    
    func testAllBasicOperatorsEvaluator() {
        let shuntingYard = ShuntingYard()
        
        let expression = shuntingYard.buildPostfixExpressionFromString("4 + 5 + (6-7)/2 * .5")
        
        let result = shuntingYard.evaluateExpression(expression)
        
        XCTAssertEqual((result!.value as! NSNumber).doubleValue, 8.75)
    }
    
    func testDivideByZeroEvaluator() {
        let shuntingYard = ShuntingYard()
        
        let expression = shuntingYard.buildPostfixExpressionFromString("5/0")
        
        let result = shuntingYard.evaluateExpression(expression)
        
        //TODO: Update to handle error
        XCTAssert(result!.value == nil)
    }
    
    
    //MARK: Helper methods
    private func toArray(inout queue: Queue<Token>) -> Array<Token> {
        var array = Array<Token>()
        
        while !queue.isEmpty() {
            let token = queue.dequeue()
            array.append(token!)
        }
        
        return array
    }
}
