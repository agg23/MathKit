//
//  CollectionsTest.swift
//  MathKit
//
//  Created by Adam Gastineau on 11/24/15.
//  Copyright © 2015 Adam Gastineau. All rights reserved.
//

import XCTest
@testable import MathKit

class CollectionsTest: XCTestCase {

    //MARK: Stack Unit Tests
    func testBasicStack() {
        var stack = Stack<Int>()
        
        stack.push(5)
        XCTAssert(stack.pop() == 5)
    }
    
    func testEightStack() {
        var stack = Stack<Int>()
        
        stack.push(5)
        stack.push(3)
        stack.push(656)
        stack.push(2431)
        stack.push(554)
        stack.push(1234)
        stack.push(15)
        stack.push(545)
        XCTAssert(stack.pop() == 545)
        XCTAssert(stack.pop() == 15)
        XCTAssert(stack.pop() == 1234)
        XCTAssert(stack.pop() == 554)
        XCTAssert(stack.pop() == 2431)
        XCTAssert(stack.pop() == 656)
        XCTAssert(stack.pop() == 3)
        XCTAssert(stack.pop() == 5)
    }
    
    //MARK: Queue Unit Tests
    func testBasicQueue() {
        var queue = Queue<Int>()
        
        queue.enqueue(5)
        XCTAssertEqual(queue.dequeue(), 5)
    }
    
    func testEightQueue() {
        var queue = Queue<Int>()
        
        queue.enqueue(5)
        queue.enqueue(3)
        queue.enqueue(656)
        queue.enqueue(2431)
        queue.enqueue(554)
        queue.enqueue(1234)
        queue.enqueue(15)
        queue.enqueue(545)
        XCTAssertEqual(queue.dequeue(), 5)
        XCTAssertEqual(queue.dequeue(), 3)
        XCTAssertEqual(queue.dequeue(), 656)
        XCTAssertEqual(queue.dequeue(), 2431)
        XCTAssertEqual(queue.dequeue(), 554)
        XCTAssertEqual(queue.dequeue(), 1234)
        XCTAssertEqual(queue.dequeue(), 15)
        XCTAssertEqual(queue.dequeue(), 545)
        XCTAssertEqual(queue.dequeue(), nil)
    }

    
    func testEmptyQueue() {
        var queue = Queue<Int>()
        
        XCTAssert(queue.dequeue() == nil)
    }

}
