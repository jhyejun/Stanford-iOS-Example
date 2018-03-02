//
//  ViewController.swift
//  Stanford-iOS-Example
//
//  Created by 장혜준 on 2018. 3. 2..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInsDisplay = display.text!
            
            display.text = textCurrentlyInsDisplay + digit
        }
        
        else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        
        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol == "π" {
                display.text = String(Double.pi)
                print(String(Double.pi))
            }
        }
    }
}

