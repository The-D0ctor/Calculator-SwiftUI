//
//  SwiftUIView.swift
//  CalculatorSwiftUI
//
//  Created by Sébastien Rochelet on 18/10/2024.
//

import SwiftUI

struct CalculatorButton: View {    
    var image: Image
    var backgroundColor: Color = .gray
    var number: Number? = nil
    var operaror: Operator? = nil
    var action: (() -> Void)? = nil
    var longPressAction: (() -> Void)? = nil
    
    let calculatorService: CalculatorService = .shared
    var body: some View {
        GeometryReader { proxy in
            let paddingWidth: Double = proxy.size.width / 4
            let paddingHeight: Double = proxy.size.height / 4
            Button {
                if number != nil {
                    calculatorService.addNumber(number!)
                }
                if operaror != nil {
                    calculatorService.addOperator(operaror!)
                }
                action?()
            } label: {
                image.resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: proxy.size.width - paddingWidth * 2, height: proxy.size.height - paddingHeight * 2)
                    .padding(.horizontal, paddingWidth)
                    .padding(.vertical, paddingHeight)
                    .background(Capsule().fill(backgroundColor))
            }
        }/*.highPriorityGesture(LongPressGesture(minimumDuration: 0.5).onEnded({ _ in
            print("lol")
            longPressAction?()
        }))*/
    }
}

#Preview {
    CalculatorButton(image: Image("delete.left"))
        .frame(width: 100, height: 100)
}
