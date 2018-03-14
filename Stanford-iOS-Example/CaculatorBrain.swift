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
    
    func performOperation(symbol: String) {
        switch symbol {
        case "π" : accumulator = .pi
        case "√" : accumulator = sqrt(accumulator)
        default : break
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}
