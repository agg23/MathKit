//
//  ShuntingYard.swift
//  MathKit
//
//  Created by Adam Gastineau on 11/24/15.
//  Copyright © 2015 Adam Gastineau. All rights reserved.
//

import Foundation

class ShuntingYard: NSObject {
    var outputQueue = Queue<Token>()
    var functionStack = Stack<Token>()
    
    var tokenizer = Tokenizer()
    
    func parseString(string:String) {
        // Tokenize
        let tokens = tokenizer.tokenizeString(string)
        
        for token in tokens {
            switch token.type {
                case TokenType.Decimal:
                    self.outputQueue.enqueue(token)
                
                case TokenType.StringOperator:
                    self.functionStack.push(token)
                
                case TokenType.Separator:
                    while !self.functionStack.isEmpty() && self.functionStack.peek().type != TokenType.OpenParen {
                        self.outputQueue.enqueue(self.functionStack.pop())
                    }
                    if self.functionStack.isEmpty() {
                        NSException(name: "Unmatched parens", reason: "Unmatched parens", userInfo: nil).raise()
                    }
                
                case TokenType.Operator:
                    // Handle operators
                    while !self.functionStack.isEmpty() && self.functionStack.peek().type != TokenType.Operator {
                        let currentOperatorPrecedence = operatorPrecedence(token)
                        let nextOperatorPrecednce = operatorPrecedence(self.functionStack.peek())
                        if operatorIsLeftAssociative(token) && currentOperatorPrecedence <= nextOperatorPrecednce ||
                            !operatorIsLeftAssociative(token) && currentOperatorPrecedence < nextOperatorPrecednce {
                            self.outputQueue.enqueue(self.functionStack.pop())
                        } else {
                            break
                        }
                    }
                    
                    self.functionStack.push(token)
                
                case TokenType.OpenParen:
                    self.functionStack.push(token)
                
                case TokenType.CloseParen:
                    while !self.functionStack.isEmpty() && self.functionStack.peek().type != TokenType.OpenParen {
                        self.outputQueue.enqueue(self.functionStack.pop())
                    }
                    if self.functionStack.isEmpty() {
                        NSException(name: "Unmatched parens", reason: "Unmatched parens", userInfo: nil).raise()
                    }
                    self.functionStack.pop()
                    if self.functionStack.peek().type == TokenType.StringOperator {
                        self.outputQueue.enqueue(self.functionStack.pop())
                    }
                
                default:
                    break
            }
        }
        
        while !self.functionStack.isEmpty() {
            let token = self.functionStack.pop()
            
            if token.type == TokenType.OpenParen || token.type == TokenType.CloseParen {
                NSException(name: "Unmatched parens", reason: "Unmatched parens", userInfo: nil).raise()
            }
            
            self.outputQueue.enqueue(token)
        }
    }
    
    func operatorPrecedence(token: Token) -> Int {
        if token.type == TokenType.Operator {
            switch (token.value as! String) {
                case "+", "-":
                    return 1;
                case "/", "*":
                    return 2;
                case "^":
                    return 3;
                default:
                    return -1;
            }
        } else if token.type == TokenType.OpenParen || token.type == TokenType.CloseParen {
            return 4
        }
        
        return -1
    }
    
    func operatorIsLeftAssociative(token: Token) -> Bool {
        if token.value as! String == "^" {
            return false
        }
        
        return true;
    }
}