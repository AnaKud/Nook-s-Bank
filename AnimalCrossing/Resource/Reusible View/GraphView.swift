// GraphView.swift
// Created by Anastasiya Kudasheva on 08.07.2021.

import SwiftUI
import SwiftUICharts

struct GraphView: View {
	private let data: [Double]
	private let specifier: String = "%.0f"

	private let style = ChartStyle(backgroundColor: GraphColors.backgroundColor,
								   accentColor: .black,
								   gradientColor: GradientColor(start: GraphColors.gradientStart,
																end: GraphColors.gradientStop),
								   textColor: .black,
								   legendTextColor: .black,
								   dropShadowColor: .black)

	var body: some View {
		LineView(data: self.data,
				 title: nil,
				 legend: nil,
				 style: self.style,
				 valueSpecifier: self.specifier,
				 legendSpecifier: self.specifier)
			.frame(width: AppContraints.GraphPrices.width,
				   height: AppContraints.GraphPrices.height,
				   alignment: .center)
	}

	init(data: [Double]) {
		self.data = data
	}
}
