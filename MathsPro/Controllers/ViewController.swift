//
//  ViewController.swift
//  Calculator
//
//  Created by Henry Rogers on 12/14/19.
//  Copyright © 2019 Henry Rogers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    
    var calculator = CalculatorLogic()
    
    var stillEnteringNum = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberLabel.text = "0"
        self.numberLabel.adjustsFontSizeToFitWidth = true
        calculator.delegate = self
    }
    
    // MARK: Keys
    @IBAction func numberKeyPressed(_ sender: UIButton) {
        if let digit = Int(sender.currentTitle!){
            calculator.newDigit(digit)
        } else {
            calculator.addDecimalToCurrentNumber()
        }
        buttonDimmer(sender)
        calculator.lastButton(title: sender.currentTitle!)
    }
    
    @IBAction func opperatorKey(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            calculator.percentCurrentNumber()
        case 2:
            calculator.negateCurrentNumber()
        case 3:
            calculator.clear(full: true)
        case 7:
            calculator.connectingOperators(title: 1)
        case 6:
            calculator.connectingOperators(title: 2)
        case 5:
            calculator.connectingOperators(title: 3)
        case 4:
            calculator.connectingOperators(title: 4)
        case 0:
            calculator.twoNumberCalc()
        default:
            print("error time buddy")
            
        }
        calculator.lastButton(title: sender.currentTitle!)
        buttonDimmer(sender)
    }
    
    
    
    // MARK: Functions
    func buttonDimmer(_ sender: UIButton){
        sender.alpha = 0.75
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            sender.alpha = 1
        }
    }
}

extension ViewController: CalculatorBrainDelegate{
    func updateLabel(with number: String){
        if number == "" {
            numberLabel.text = number
        } else {
            numberLabel.text = number
        }
    }
}


