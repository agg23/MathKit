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
    
    func buildPostfixExpressionFromString(string:String) -> Expression {
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
                    while !self.functionStack.isEmpty() && self.functionStack.peek().type == TokenType.Operator {
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
                    while true {
                        if !self.functionStack.isEmpty() {
                            if self.functionStack.peek().type == TokenType.OpenParen {
                                break
                            }
                        } else {
                            NSException(name: "Unmatched parens", reason: "Unmatched parens", userInfo: nil).raise()
                        }
                        
                        self.outputQueue.enqueue(self.functionStack.pop())
                    }
                    
                    // Pop open paren off stack
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
        
        var orderedTokens = Array<Token>()
        var variables = Array<Token>()
        
        while !self.outputQueue.isEmpty() {
            let token = self.outputQueue.dequeue()!
            
            if token.type == TokenType.Variable {
                variables.append(token)
            }
            
            orderedTokens.append(token)
        }
        
        return Expression(tokens: orderedTokens, variables: variables)
    }
    
    func evaluateExpression(expression: Expression) -> ResultToken? {
        var stack = Stack<Token>()
        
        for token in expression.postfixTokens {
            if token.type == TokenType.Decimal {
                stack.push(token)
            } else if token.type == TokenType.Operator /*|| token.type == TokenType.StringOperator*/ {
                //TODO: Check if stack contains sufficient number of values for this operator
                
                let result = evaluateOperator(&stack, operatorString: token.value as! String)

                if result != nil {
                    stack.push(result!)
                }
            }
        }
        
        if stack.isEmpty() {
            //TODO: Throw error
            print("Empty stack error")
        }
        
        let token = stack.pop()
        
        if token.type == TokenType.Decimal {
            return ResultToken(token: token)
        } else if token.type == TokenType.Result {
            return token as? ResultToken
        } else {
            return ResultToken(errorMessage: "Invalid stack result")
        }
    }
    
    func evaluateOperator(inout stack: Stack<Token>, operatorString: String) -> ResultToken? {
        switch(operatorString) {
            case "+":
                let second = stack.pop().value as! NSNumber
                let first = stack.pop().value as! NSNumber
                
                return Operations.add(first, second: second)
            case "-":
                let second = stack.pop().value as! NSNumber
                let first = stack.pop().value as! NSNumber
                
                return Operations.subtract(first, second: second)
            default:
                return nil
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