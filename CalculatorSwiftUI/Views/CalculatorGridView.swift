//
//  CalculatorGridView.swift
//  CalculatorSwiftUI
//
//  Created by Sébastien Rochelet on 21/10/2024.
//

import SwiftUI

struct CalculatorGridView: View {
    var gridSize: CGSize
    var buttons: [[CalculatorButton]]
    
    var body: some View {
            Grid {
                ForEach(buttons.indices, id: \.self) { rowIndice in
                    GridRow {
                        ForEach(buttons[rowIndice].indices, id: \.self) { cellIndice in
                            let gridWith: CGFloat = gridSize.width
                            let gridHeight: CGFloat = gridSize.height
                            let rowCount: Double = Double(buttons[rowIndice].count)
                            let columnCount: Double = Double(buttons.count)
                            let cellSpacing: CGFloat = 8
                            let cellWidth: CGFloat = (gridWith -  (rowCount - 1) * cellSpacing) / rowCount
                            let cellHeight: CGFloat = gridHeight > cellWidth * columnCount + (columnCount - 1) * cellSpacing ? cellWidth : (gridHeight - (columnCount - 1) * cellSpacing) / columnCount
                            buttons[rowIndice][cellIndice]
                                .frame(width: (gridWith -  (rowCount - 1) * cellSpacing) / rowCount, height: cellHeight)
                        }
                    }
                }.frame(alignment: .bottom)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
}

#Preview {
    CalculatorGridView(gridSize: CGSizeMake(400, 400), buttons: [[CalculatorButton(image: Image(systemName: "plus")), CalculatorButton(image: Image(systemName: "plus")), CalculatorButton(image: Image(systemName: "plus")), CalculatorButton(image: Image(systemName: "plus"))], [CalculatorButton(image: Image(systemName: "plus")), CalculatorButton(image: Image(systemName: "plus")), CalculatorButton(image: Image(systemName: "plus")), CalculatorButton(image: Image(systemName: "plus"))]])
}
