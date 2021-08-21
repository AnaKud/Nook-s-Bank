//
//  GraphView.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 08.07.2021.
//

import SwiftUI
import SwiftUICharts

struct GraphView: View {
    let data: [Double]
    let valueSpecifier: String = "%.0f"

    var body: some View {
        LineView(data: self.data,
				 title: nil,
				 legend: nil,
				 style: GraphChartStyle.style,
				 valueSpecifier: valueSpecifier,
				 legendSpecifier: "%.0f")
            .frame(width: AppContraints.GraphPrices.width, height: AppContraints.GraphPrices.height, alignment: .center)
    }

    init(data: [Double]?) {
        self.data = data ?? [Double]()
    }
}

struct GraphChartStyle {
    static let style = ChartStyle(backgroundColor: GraphColors.backgroundColor,
								  accentColor: .black,
								  gradientColor: GradientColor(start: GraphColors.gradientStart,
															   end: GraphColors.gradientStop),
								  textColor: .black,
								  legendTextColor: .black,
								  dropShadowColor: .black)
}
