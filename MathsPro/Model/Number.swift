//
//  Number.swift
//  Calculator
//
//  Created by Henry Rogers on 1/2/20.
//  Copyright © 2020 Henry Rogers. All rights reserved.
//

import Foundation

struct Number {
    
    var value: Double = 0
    var deciPts: Int = 0
    var sign: Double = 1.0
    
    var stable = true
    
    mutating func append(_ digit: Int){
        if !stable {
            clear()
            stable = true
        }
        if fetchNumberString().count < 13{
            let deciFactor: Double?
            if deciPts > 0{
                deciFactor = pow(10.0, Double(deciPts))
            } else {
                deciFactor = 10
            }
            value = value * deciFactor!
            value += Double(digit)
            if deciPts > 0 {
                value /= deciFactor!
                deciPts += 1
            }
        }
    }
    
    mutating func clear(){
        value = 0
        deciPts = 0
        sign = 1.0
    }
    
    mutating func fetchNumberString() -> String {
        if value == .infinity || value == -.infinity{
            clear()
            return "Error"
        }
        if value <= pow(10, -320) && value > 0 {
            return "Error"
        }
        if value == .zero {
            sign = 1
        }
        let formatter = NumberFormatter()
        let MAX_VALUE: Double = 10000000000
        let MIN_VALUE: Double = 0.0001
        formatter.maximumSignificantDigits = 12
        var numberString: String?
        if (value > MAX_VALUE || value < MIN_VALUE) && value != 0 {
            formatter.numberStyle = .scientific
            numberString = formatter.string(from: NSNumber(value: fetchNumberValue()))!
        } else {
            formatter.numberStyle = .decimal
            numberString = formatter.string(from: NSNumber(value: fetchNumberValue()))!
            if deciPts != 0 && Double(Int(value)) == value{
                numberString! += "."
                var zerosToAdd = deciPts - 1
                while zerosToAdd > 0 {
                    numberString! += "0"
                    zerosToAdd -= 1
                }
            }
        }
        
        if numberString == "NaN"{
            numberString = "Undef"
        }
        return numberString ?? "Error"
    }
    
    func fetchNumberValue() -> Double{
        return value * sign
    }
    mutating func percent(){
        value *= 0.01
        stable = false
    }
    
    mutating func negate(){
        sign *= -1
    }
}
