//
//  ContentView.swift
//  CalculatorSwiftUI
//
//  Created by Sébastien Rochelet on 18/10/2024.
//

import SwiftUI

struct ContentView: View {
    let acImage = Image("ac")
    let deleteImage = Image("delete.left")
    var acButton: CalculatorButton = CalculatorButton(image: Image("ac"), action: CalculatorService.shared.deleteAll)
    var deleteButton: CalculatorButton = CalculatorButton(image: Image("delete.left"), action: CalculatorService.shared.delteOne, longPressAction: CalculatorService.shared.deleteAll)
    let plusMinusButton = CalculatorButton(image: Image("plus.forwardslash.minus"), action: CalculatorService.shared.plusMinus)
    let percentButton = CalculatorButton(image: Image("percent"), action: CalculatorService.shared.percent)
    let zeroButton = CalculatorButton(image: Image("0"), backgroundColor: .myDarkGray, number: .zero)
    let oneButton = CalculatorButton(image: Image("1"), backgroundColor: .myDarkGray, number: .one)
    let twoButton = CalculatorButton(image: Image("2"), backgroundColor: .myDarkGray, number: .two)
    let threeButton = CalculatorButton(image: Image("3"), backgroundColor: .myDarkGray, number: .three)
    let fourButton = CalculatorButton(image: Image("4"), backgroundColor: .myDarkGray, number: .four)
    let fiveButton = CalculatorButton(image: Image("5"), backgroundColor: .myDarkGray, number: .five)
    let sixButton = CalculatorButton(image: Image("6"), backgroundColor: .myDarkGray, number: .six)
    let sevenButton = CalculatorButton(image: Image("7"), backgroundColor: .myDarkGray, number: .seven)
    let eightButton = CalculatorButton(image: Image("8"), backgroundColor: .myDarkGray, number: .eight)
    let nineButton = CalculatorButton(image: Image("9"), backgroundColor: .myDarkGray, number: .nine)
    let commaButton = CalculatorButton(image: Image("comma"), backgroundColor: .myDarkGray, action: CalculatorService.shared.addComma)
    let equalButton = CalculatorButton(image: Image("equal"), backgroundColor: .orange, action: CalculatorService.shared.equals)
    let plusButton = CalculatorButton(image: Image("plus"), backgroundColor: .orange, operaror: .add)
    let minusButton = CalculatorButton(image: Image("minus"), backgroundColor: .orange, operaror: .subtract)
    let multiplyButton = CalculatorButton(image: Image("multiply"), backgroundColor: .orange, operaror: .multiply)
    let divideButton = CalculatorButton(image: Image("divide"), backgroundColor: .orange, operaror: .divide)
    let hiddenButton = CalculatorButton(image: Image("hidden"), backgroundColor: .clear)
    
    @State var portraitButtons: [[CalculatorButton]] = [[]]
    @State var landscapeButtons: [[CalculatorButton]] = [[]]
    
    @ObservedObject var calculatorService: CalculatorService = CalculatorService.shared
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GeometryReader { proxy in
                VStack {
                    VStack(alignment: .trailing) {
                        Text(calculatorService.history)
                            .font(.system(size: 30))
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                            .foregroundStyle(.gray)
                        Text(calculatorService.result)
                            .font(.system(size: 60))
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                    .frame(height: 0.3 * proxy.size.height, alignment: .bottomTrailing)
                    
                    GeometryReader { gridProxy in
                        CalculatorGridView(gridSize: gridProxy.size, buttons: gridProxy.size.height >= gridProxy.size.width ? portraitButtons : landscapeButtons)
                            .frame(alignment: .bottom)
                    }
                    
                }
            }
            .padding()
        }
        .onReceive(calculatorService.$result, perform: { result in
            if (portraitButtons[0].count != 0) {
                portraitButtons[0][0] = (result == "0" || calculatorService.history != "") ? acButton : deleteButton
            }
            if (landscapeButtons[0].count != 0) {
                landscapeButtons[0][3] = (result == "0" || calculatorService.history != "") ? acButton : deleteButton
            }
        })
        .onAppear {
            portraitButtons = [
                [
                    acButton,
                    plusMinusButton,
                    percentButton,
                    divideButton
                ],
                [
                    sevenButton,
                    eightButton,
                    nineButton,
                    multiplyButton
                ],
                [
                    fourButton,
                    fiveButton,
                    sixButton,
                    minusButton
                ],
                [
                    oneButton,
                    twoButton,
                    threeButton,
                    plusButton
                ],
                [
                    hiddenButton,
                    zeroButton,
                    commaButton,
                    equalButton,
                ]
            ]
            
            landscapeButtons = [
                [
                    sevenButton,
                    eightButton,
                    nineButton,
                    acButton,
                    divideButton
                ],
                [
                    fourButton,
                    fiveButton,
                    sixButton,
                    plusMinusButton,
                    multiplyButton,
                ],
                [
                    oneButton,
                    twoButton,
                    threeButton,
                    percentButton,
                    minusButton,
                ],
                [
                    hiddenButton,
                    zeroButton,
                    commaButton,
                    equalButton,
                    plusButton
                ]
            ]
        }
    }
}

#Preview {
    ContentView()
}
