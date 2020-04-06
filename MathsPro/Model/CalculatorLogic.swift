import Foundation

protocol CalculatorBrainDelegate {
    func updateLabel(with number: String)
}

struct CalculatorLogic {
    
    var delegate: CalculatorBrainDelegate?
    
    var numberOne = Number()
    var numberTwo = Number()
    var numberAnswer = Number()
    
    var opperation: Double?
    
    var doneWithFirstNumber: Bool = false
    var lastOpperation: [String: Double] = ["number1": 0, "number2": 0, "opp": 1 ]
    var lastButtonEquals: String = "EQ"
    
    mutating func newDigit(_ digit: Int) {
        if !doneWithFirstNumber {
            if lastButtonEquals == "EQ"{
                clear(full: true)
            }
            numberOne.append(digit)
            delegate?.updateLabel(with: numberOne.fetchNumberString())
        } else {
            numberTwo.append(digit)
            delegate?.updateLabel(with: numberTwo.fetchNumberString())
        }
    }
    
    mutating func addDecimalToCurrentNumber(){
        if !doneWithFirstNumber && numberOne.deciPts == 0 {
            if lastButtonEquals == "EQ"{
                clear(full: true)
            }
            numberOne.deciPts += 1
            delegate?.updateLabel(with: numberOne.fetchNumberString())
        } else if (numberTwo.deciPts == 0) {
            numberTwo.deciPts += 1
            delegate?.updateLabel(with: numberTwo.fetchNumberString())
        }
    }
    
    mutating func clear(full: Bool){
        if full {
            numberOne.clear()
        }
        numberTwo.clear()
        numberAnswer.clear()
        opperation = nil
        doneWithFirstNumber = false
        lastButtonEquals = ""
        delegate?.updateLabel(with: numberOne.fetchNumberString())
        
    
    }
    
    mutating func percentCurrentNumber(){
        if !doneWithFirstNumber {
            numberOne.percent()
            delegate?.updateLabel(with: numberOne.fetchNumberString())
        } else {
            numberTwo.percent()
            delegate?.updateLabel(with: numberTwo.fetchNumberString())
        }
    }
    
    mutating func negateCurrentNumber(){
        if !doneWithFirstNumber {
            numberOne.negate()
            delegate?.updateLabel(with: numberOne.fetchNumberString())
        } else {
            numberTwo.negate()
            delegate?.updateLabel(with: numberTwo.fetchNumberString())
        }
    }
    
    mutating func connectingOperators(title: Double){
        if opperation != nil && doneWithFirstNumber && numberTwo.fetchNumberValue() != 0{
            let ans = Operations.operate(numberOne.fetchNumberValue(), numberTwo.fetchNumberValue(), opporation: opperation ?? 0)
            if ans < 0 {
                numberAnswer.sign = -1
                numberAnswer.value = ans * -1
            } else {
                numberAnswer.value = ans
            }
            numberOne = numberAnswer
            lastOpperation = ["number1": numberAnswer.fetchNumberValue(), "number2": numberTwo.fetchNumberValue(), "opp": title]
        }
        clear(full: false)
        doneWithFirstNumber = true
        lastButton(title: "OP")
        opperation = title
    }
    
    
    mutating func twoNumberCalc(){
        if numberTwo.fetchNumberValue() == 0 && opperation == nil{
            clear(full: false)
            lastOpperation = ["number1": numberOne.fetchNumberValue(), "number2": 0, "opp": 1]
            return
        }
        
        if lastButtonEquals !=  "EQ" {
            if let opp = opperation{
                let num1 = numberOne.fetchNumberValue()
                let num2 = numberTwo.fetchNumberValue()
                let ans = Operations.operate(num1, num2, opporation: opp)
                if ans < 0 {
                    numberAnswer.sign = -1
                    numberAnswer.value = ans * -1
                } else {
                    numberAnswer.value = ans
                }
                lastOpperation = ["number1": numberAnswer.fetchNumberValue(), "number2": num2, "opp": opp]
            }
        } else {
            let num1 = lastOpperation["number1"]!
            let num2 = lastOpperation["number2"]!
            let opp = lastOpperation["opp"]!
            let ans = Operations.operate(num1, num2, opporation: opp)
            if ans < 0 {
                numberAnswer.sign = -1
                numberAnswer.value = ans * -1
            } else {
                numberAnswer.value = ans
            }
            lastOpperation = ["number1": numberAnswer.fetchNumberValue(), "number2": num2, "opp": opp]
        }
        numberOne = numberAnswer
        numberTwo.clear()
        numberAnswer.clear()
        doneWithFirstNumber = false
        lastButtonEquals = ""
        delegate?.updateLabel(with: numberOne.fetchNumberString())
    }
    
    mutating func lastButton (title: String){
        lastButtonEquals = ""
        if title == "=" {
            lastButtonEquals = "EQ"
        }
    }
}

