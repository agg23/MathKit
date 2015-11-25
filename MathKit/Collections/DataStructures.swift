//
//  Collections.swift
//  MathKit
//
//  Created by Adam Gastineau on 11/24/15.
//  Copyright © 2015 Adam Gastineau. All rights reserved.
//

import Foundation

struct Stack<Element> {
    var stack = [Element]()
    mutating func push(item: Element) {
        stack.append(item)
    }
    
    mutating func pop() -> Element {
        return stack.removeLast()
    }
    
    func peek() -> Element {
        return stack.last!
    }
    
    func isEmpty() -> Bool {
        return stack.count == 0
    }
}

private class QueueItem<Element> {
    let value: Element!
    var next: QueueItem?
    
    init(v: Element?) {
        self.value = v;
    }
}

struct Queue<Element> {
    
    private var first: QueueItem<Element>
    private var last: QueueItem<Element>
    
    init() {
        last = QueueItem(v: nil)
        first = last
    }
    
    mutating func enqueue(item: Element) {
        last.next = QueueItem(v: item)
        last = last.next!
    }
    
    mutating func dequeue() -> Element? {
        if first.next != nil {
            let front = first.next
            first = front!
            return front!.value
        } else {
            return nil
        }
    }
    
    func isEmpty() -> Bool {
        return first === last
    }
}