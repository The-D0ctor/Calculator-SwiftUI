//
//  CalculatorService.swift
//  CalculatorSwiftUI
//
//  Created by Sébastien Rochelet on 22/10/2024.
//

import Foundation
import SwiftUI

class CalculatorService: ObservableObject {
    @Published var result: String = "0"
    @Published var history: String = ""
    
    private init() {}
    
    private var numbers: [String] = ["0"]
    private var operators: [Operator] = []
    
    @MainActor
    static let shared = CalculatorService()
    
    private func updateResult() {
        var tempResult: String = "0"
        for i in numbers.indices {
            let numberFormatted = numbers[i]
            tempResult == "0" ? tempResult = numberFormatted : tempResult.append(numberFormatted)
            if (operators.count > i) {
                tempResult.append(operators[i].rawValue)
            }
        }
        result = tempResult.replacingOccurrences(of: ".", with: ",")
        history = ""
    }
    
    func addNumber(_ number: Number) {
        if history != "" {
            numbers[0] = number.rawValue
        }
        else if numbers.count > operators.count {
            numbers[operators.count] == "0" ? numbers[operators.count] = number.rawValue : numbers[operators.count].append(number.rawValue)
        }
        else {
            numbers.append(number.rawValue)
        }
        print(numbers)
        updateResult()
    }
    
    func addComma() {
        let indiceLast = numbers.indices.last
        if ((numbers.last?.contains(where: { character in
            character == "."
        })) == false) {
            numbers[indiceLast!].append(".")
        }
        print(numbers)
        updateResult()
    }
    
    func addOperator(_ op: Operator) {
        if numbers.count > operators.count {
            if (numbers.last == "-") {
                numbers.removeLast()
                operators[operators.count - 1] = op
            }
            else {
                operators.append(op)
            }
        } else if (op == .subtract && operators.last != .subtract && operators.last != .add) {
            numbers.append("-")
        } else {
            operators[operators.count - 1] = op
        }
        print(operators)
        updateResult()
    }
    
    func equals() {
        if ((numbers.count > 1 || numbers[0].last == "%") && numbers.last != "-") {
            if (numbers[0].last == "e") {
                numbers[0].removeLast()
                print(numbers[0])
            }
            var tempResult: Double = numbers[0].last == "%" ? Double(numbers[0].replacingOccurrences(of: "%", with: ""))! / 100 : Double(numbers[0])!
            var tempHistory: String = numbers[0].replacingOccurrences(of: ".", with: ",")
            for i in 1 ..< numbers.count {
                print(numbers[i])
                if (numbers[i].last == "e") {
                    numbers[i].removeLast()
                    print(numbers[i])
                }
                tempHistory.append(operators[i - 1].rawValue)
                tempHistory.append(numbers[i].replacingOccurrences(of: ".", with: ","))
                if (result != "Diviser par zéro") {
                    switch operators[i - 1] {
                    case .add:
                        tempResult += numbers[i].last == "%" ? Double(numbers[i].replacingOccurrences(of: "%", with: ""))! / 100 : Double(numbers[i])!
                    case .subtract:
                        tempResult -= numbers[i].last == "%" ? Double(numbers[i].replacingOccurrences(of: "%", with: ""))! / 100 : Double(numbers[i])!
                    case .multiply:
                        tempResult *= numbers[i].last == "%" ? Double(numbers[i].replacingOccurrences(of: "%", with: ""))! / 100 : Double(numbers[i])!
                    case .divide:
                        if (Double(numbers[i])! != 0) {
                            tempResult /= numbers[i].last == "%" ? Double(numbers[i].replacingOccurrences(of: "%", with: ""))! / 100 : Double(numbers[i])!
                        }
                        else {
                            result = "Diviser par zéro"
                        }
                    }
                }
            }
            if (result != "Diviser par zéro") {
                result = String(format: "%.9g", tempResult).replacingOccurrences(of: ".", with: ",").replacingOccurrences(of: "+", with: "")
            }
            history = tempHistory
            numbers = [String(format: "%g", tempResult).replacingOccurrences(of: "+", with: "")]
            print(numbers)
            operators.removeAll()
        }
    }
    
    func deleteAll() {
        numbers = ["0"]
        result = "0"
        operators.removeAll()
        history = ""
    }
    
    func delteOne() {
        if numbers.count == operators.count {
            operators.removeLast()
        } else if numbers.count == 1 && numbers[0].count == 1 {
            numbers = ["0"]
        } else if (numbers.last?.count == 1) {
            numbers.removeLast()
        }
        else {
            numbers[numbers.count - 1].removeLast()
        }
        print(numbers)
        print(operators)
        updateResult()
    }
    
    func plusMinus() {
        if numbers.count == operators.count {
            numbers.append("-")
        }
        else if numbers.last != "0" && numbers.last?.first != "-" {
            numbers[numbers.count - 1] = "-" + numbers[numbers.count - 1]
        } else if (numbers.last?.first == "-") {
            numbers[numbers.count - 1].removeFirst()
        }
        updateResult()
    }
    
    func percent() {
        if numbers.count == operators.count {
            operators.removeLast()
        }
        if (numbers.last?.last != "%") {
            numbers[numbers.count - 1].append("%")
        }
        updateResult()
    }
}

#Preview {
    ContentView()
}
