//
//  CaculatorBrain.swift
//  Stanford-iOS-Example
//
//  Created by 장혜준 on 2018. 3. 14..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import Foundation

class CaculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var operations: Dictionary<String, Double> = [
        "π" : .pi,
        "e" : M_E
    ]
    
    func performOperation(symbol: String) {
        if let constant = operations[symbol] {
            accumulator = constant
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}
