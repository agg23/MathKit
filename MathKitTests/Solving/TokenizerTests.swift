//
//  TokenizerTests.swift
//  MathKit
//
//  Created by Adam Gastineau on 11/24/15.
//  Copyright © 2015 Adam Gastineau. All rights reserved.
//

import XCTest
@testable import MathKit

class TokenizerTests: XCTestCase {

    func testBasicTokenizer() {
        let tokenizer = Tokenizer()
        let array: Array<Token> = tokenizer.tokenizeString("5.34 + 453")
        XCTAssertEqual(array[0].value as? NSNumber, 5.34)
        XCTAssertEqual(array[1].value as? String, "+")
        XCTAssertEqual(array[2].value as? NSNumber, 453)
    }
    
    func testBasicVariableTokenizer() {
        let tokenizer = Tokenizer()
        let array: Array<Token> = tokenizer.tokenizeString("5.34 + 453 + x = 4")
        XCTAssertEqual(array[0].value as? NSNumber, 5.34)
        XCTAssertEqual(array[1].value as? String, "+")
        XCTAssertEqual(array[2].value as? NSNumber, 453)
        XCTAssertEqual(array[3].value as? String, "+")
        XCTAssertEqual(array[4].value as? String, "x")
        XCTAssertEqual(array[5].value as? String, "=")
        XCTAssertEqual(array[6].value as? NSNumber, 4)
    }

}
