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
        XCTAssertEqual(tokenizer.tokenizeString("5.34 + 453"), ["5.34", "+", "453"])
    }

}
