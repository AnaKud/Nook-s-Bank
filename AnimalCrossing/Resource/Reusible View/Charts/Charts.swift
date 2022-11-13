//  Charts.swift
//  LineChart
//  Created by András Samu on 2019. 09. 02..
//  Copyright © 2019. András Samu.

import SwiftUI

// swiftLint: disable: next identifier_name_violation
public struct LineView: View {
	@ObservedObject var data: ChartData
	public var title: String?
	public var legend: String?
	public var style: ChartStyle
	public var darkModeStyle: ChartStyle
	public var valueSpecifier: String
	public var legendSpecifier: String

	@Environment(\.colorScheme) var colorScheme: ColorScheme
	@State private var showLegend = false
	@State private var dragLocation: CGPoint = .zero
	@State private var indicatorLocation: CGPoint = .zero
	@State private var closestPoint: CGPoint = .zero
	@State private var opacity: Double = 0
	@State private var currentDataNumber: Double = 0
	@State private var hideHorizontalLines = false
	
	public init(data: [Double],
				title: String? = nil,
				legend: String? = nil,
				style: ChartStyle = Styles.lineChartStyleOne,
				valueSpecifier: String? = "%.1f",
				legendSpecifier: String? = "%.2f") {
		self.data = ChartData(points: data)
		self.title = title
		self.legend = legend
		self.style = style
		self.valueSpecifier = valueSpecifier!
		self.legendSpecifier = legendSpecifier!
		self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
	}

	public var body: some View {
		GeometryReader { geometry in
			VStack(alignment: .leading, spacing: 8) {
				Group {
					if (self.title != nil){
						Text(self.title!)
							.font(.title)
							.bold().foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.textColor : self.style.textColor)
					}
					if (self.legend != nil) {
						Text(self.legend!)
							.font(.callout)
							.foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.style.legendTextColor)
					}
				}.offset(x: 0, y: 20)
				ZStack {
					GeometryReader { reader in
						Rectangle()
							.foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.backgroundColor : self.style.backgroundColor)
						if(self.showLegend) {
							Legend(data: self.data,
								   frame: .constant(reader.frame(in: .local)),
								   hideHorizontalLines: self.$hideHorizontalLines,
								   specifier: legendSpecifier)
							.transition(.opacity)
							.animation(Animation.easeOut(duration: 1).delay(1))
						}
						Line(data: self.data,
							 frame: .constant(CGRect(x: 0,
													 y: 0,
													 width: reader.frame(in: .local).width - 30,
													 height: reader.frame(in: .local).height + 25)),
							 touchLocation: self.$indicatorLocation,
							 showIndicator: self.$hideHorizontalLines,
							 minDataValue: .constant(nil),
							 maxDataValue: .constant(nil),
							 showBackground: false,
							 gradient: self.style.gradientColor
						)
						.offset(x: 30, y: 0)
						.onAppear() {
							self.showLegend = true
						}
						.onDisappear() {
							self.showLegend = false
						}
					}
					.frame(width: geometry.frame(in: .local).size.width, height: 240)
					.offset(x: 0, y: 40 )
					MagnifierRect(currentNumber: self.$currentDataNumber, valueSpecifier: self.valueSpecifier)
						.opacity(self.opacity)
						.offset(x: self.dragLocation.x - geometry.frame(in: .local).size.width/2, y: 36)
				}
				.frame(width: geometry.frame(in: .local).size.width, height: 240)
				.gesture(DragGesture()
					.onChanged({ value in
						self.dragLocation = value.location
						self.indicatorLocation = CGPoint(x: max(value.location.x-30,0), y: 32)
						self.opacity = 1
						self.closestPoint = self.getClosestDataPoint(toPoint: value.location, width: geometry.frame(in: .local).size.width-30, height: 240)
						self.hideHorizontalLines = true
					})
						.onEnded({ value in
							self.opacity = 0
							self.hideHorizontalLines = false
						})
				)
			}
		}
	}

	func getClosestDataPoint(toPoint: CGPoint, width: CGFloat, height: CGFloat) -> CGPoint {
		let points = self.data.onlyPoints()
		let stepWidth: CGFloat = width / CGFloat(points.count - 1)
		let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
		
		let index = Int(floor((toPoint.x-15)/stepWidth))
		if (index >= 0 && index < points.count){
			self.currentDataNumber = points[index]
			return CGPoint(x: CGFloat(index) * stepWidth, y: CGFloat(points[index]) * stepHeight)
		}
		return .zero
	}
}

struct Legend: View {
	@ObservedObject var data: ChartData
	@Binding var frame: CGRect
	@Binding var hideHorizontalLines: Bool
	@Environment(\.colorScheme) var colorScheme: ColorScheme
	var specifier: String = "%.2f"
	let padding:CGFloat = 3

	var stepWidth: CGFloat {
		if data.points.count < 2 {
			return 0
		}
		return frame.size.width / CGFloat(data.points.count - 1)
	}
	var stepHeight: CGFloat {
		let points = self.data.onlyPoints()
		if let min = points.min(), let max = points.max(), min != max {
			if (min < 0){
				return (frame.size.height - padding) / CGFloat(max - min)
			}else{
				return (frame.size.height - padding) / CGFloat(max - min)
			}
		}
		return 0
	}

	var min: CGFloat {
		let points = self.data.onlyPoints()
		return CGFloat(points.min() ?? 0)
	}

	var body: some View {
		ZStack(alignment: .topLeading) {
			ForEach((0...4), id: \.self) { height in
				HStack(alignment: .center) {
					Text("\(self.getYLegendSafe(height: height), specifier: specifier)").offset(x: 0,
																								y: self.getYposition(height: height) )
						.foregroundColor(Color.legendText)
						.font(.caption)
					self.line(atHeight: self.getYLegendSafe(height: height), width: self.frame.width)
						.stroke(self.colorScheme == .dark ? Color.legendDarkColor : Color.legendColor,
								style: StrokeStyle(lineWidth: 1.5, lineCap: .round, dash: [5, height == 0 ? 0 : 10]))
						.opacity((self.hideHorizontalLines && height != 0) ? 0 : 1)
						.rotationEffect(.degrees(180), anchor: .center)
						.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
						.animation(.easeOut(duration: 0.2))
						.clipped()
				}
			}
		}
	}

	func getYLegendSafe(height: Int) -> CGFloat{
		if let legend = getYLegend() {
			return CGFloat(legend[height])
		}
		return 0
	}

	func getYposition(height: Int) -> CGFloat {
		if let legend = getYLegend() {
			return (self.frame.height - ((CGFloat(legend[height]) - min) * self.stepHeight)) - (self.frame.height / 2)
		}
		return 0
	}

	func line(atHeight: CGFloat, width: CGFloat) -> Path {
		var hLine = Path()
		hLine.move(to: CGPoint(x: 5, y: (atHeight - min) * stepHeight))
		hLine.addLine(to: CGPoint(x: width, y: (atHeight - min) * stepHeight))
		return hLine
	}

	func getYLegend() -> [Double]? {
		let points = self.data.onlyPoints()
		guard let max = points.max() else { return nil }
		guard let min = points.min() else { return nil }
		let step = Double(max - min) / 4
		return [min + step * 0, min + step * 1, min + step * 2, min + step * 3, min + step * 4]
	}
}

public struct Line: View {
	@ObservedObject var data: ChartData
	@Binding var frame: CGRect
	@Binding var touchLocation: CGPoint
	@Binding var showIndicator: Bool
	@Binding var minDataValue: Double?
	@Binding var maxDataValue: Double?
	@State private var showFull = false
	@State var showBackground = true
	var gradient = GradientColor(start: Color.gradientPurple, end: Color.gradientNeonBlue)
	var index = 0
	let padding: CGFloat = 30
	var curvedLines = true
	var stepWidth: CGFloat {
		if data.points.count < 2 {
			return 0
		}
		return frame.size.width / CGFloat(data.points.count - 1)
	}
	var stepHeight: CGFloat {
		var min: Double?
		var max: Double?
		let points = self.data.onlyPoints()
		if minDataValue != nil && maxDataValue != nil {
			min = minDataValue!
			max = maxDataValue!
		} else if let minPoint = points.min(), let maxPoint = points.max(), minPoint != maxPoint {
			min = minPoint
			max = maxPoint
		} else {
			return 0
		}
		if let min = min, let max = max, min != max {
			if (min <= 0) {
				return (frame.size.height - padding) / CGFloat(max - min)
			} else {
				return (frame.size.height - padding) / CGFloat(max - min)
			}
		}
		return 0
	}
	var path: Path {
		let points = self.data.onlyPoints()
		return curvedLines ? Path.quadCurvedPathWithPoints(points: points,
														   step: CGPoint(x: stepWidth, y: stepHeight),
														   globalOffset: minDataValue)
		: Path.linePathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight))
	}
	var closedPath: Path {
		let points = self.data.onlyPoints()
		return curvedLines ? Path.quadClosedCurvedPathWithPoints(points: points,
																 step: CGPoint(x: stepWidth, y: stepHeight),
																 globalOffset: minDataValue)
		: Path.closedLinePathWithPoints(points: points,
										step: CGPoint(x: stepWidth, y: stepHeight))
	}

	public var body: some View {
		ZStack {
			if (self.showFull && self.showBackground) {
				self.closedPath
					.fill(LinearGradient(gradient: Gradient(colors: [Color.gradientUpperBlue, .white]),
										 startPoint: .bottom, endPoint: .top))
					.rotationEffect(.degrees(180), anchor: .center)
					.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
					.transition(.opacity)
					.animation(.easeIn(duration: 1.6))
			}
			self.path
				.trim(from: 0, to: self.showFull ? 1 : 0)
				.stroke(LinearGradient(gradient: gradient.getGradient(), startPoint: .leading, endPoint: .trailing) ,style: StrokeStyle(lineWidth: 3, lineJoin: .round))
				.rotationEffect(.degrees(180), anchor: .center)
				.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
				.animation(Animation.easeOut(duration: 1.2).delay(Double(self.index)*0.4))
				.onAppear {
					self.showFull = true
				}
				.onDisappear {
					self.showFull = false
				}
			if (self.showIndicator) {
				IndicatorPoint()
					.position(self.getClosestPointOnPath(touchLocation: self.touchLocation))
					.rotationEffect(.degrees(180), anchor: .center)
					.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
			}
		}
	}
	
	func getClosestPointOnPath(touchLocation: CGPoint) -> CGPoint {
		let closest = self.path.point(to: touchLocation.x)
		return closest
	}
	
}

struct IndicatorPoint: View {
	var body: some View {
		ZStack{
			Circle()
				.fill(Color.indicatorKnob)
			Circle()
				.stroke(Color.white, style: StrokeStyle(lineWidth: 4))
		}
		.frame(width: 14, height: 14)
		.shadow(color: Color.legendColor, radius: 6, x: 0, y: 6)
	}
}

public class ChartStyle {
	public var backgroundColor: Color
	public var accentColor: Color
	public var gradientColor: GradientColor
	public var textColor: Color
	public var legendTextColor: Color
	public var dropShadowColor: Color
	public weak var darkModeStyle: ChartStyle?
	
	public init(backgroundColor: Color,
				accentColor: Color,
				secondGradientColor: Color,
				textColor: Color,
				legendTextColor: Color,
				dropShadowColor: Color){
		self.backgroundColor = backgroundColor
		self.accentColor = accentColor
		self.gradientColor = GradientColor(start: accentColor, end: secondGradientColor)
		self.textColor = textColor
		self.legendTextColor = legendTextColor
		self.dropShadowColor = dropShadowColor
	}

	public init(backgroundColor: Color,
				accentColor: Color,
				gradientColor: GradientColor,
				textColor: Color,
				legendTextColor: Color,
				dropShadowColor: Color){
		self.backgroundColor = backgroundColor
		self.accentColor = accentColor
		self.gradientColor = gradientColor
		self.textColor = textColor
		self.legendTextColor = legendTextColor
		self.dropShadowColor = dropShadowColor
	}
}

public struct GradientColor {
	public let start: Color
	public let end: Color

	public init(start: Color, end: Color) {
		self.start = start
		self.end = end
	}

	public func getGradient() -> Gradient {
		return Gradient(colors: [start, end])
	}
}

public class ChartData: ObservableObject, Identifiable {
	@Published var points: [(String,Double)]
	var valuesGiven = false
	var ID = UUID()

	public init<N: BinaryFloatingPoint>(points:[N]) {
		self.points = points.map{("", Double($0))}
	}
	public init<N: BinaryInteger>(values:[(String,N)]){
		self.points = values.map{($0.0, Double($0.1))}
		self.valuesGiven = true
	}
	public init<N: BinaryFloatingPoint>(values:[(String,N)]){
		self.points = values.map{($0.0, Double($0.1))}
		self.valuesGiven = true
	}
	public init<N: BinaryInteger>(numberValues:[(N,N)]){
		self.points = numberValues.map{(String($0.0), Double($0.1))}
		self.valuesGiven = true
	}
	public init<N: BinaryFloatingPoint & LosslessStringConvertible>(numberValues:[(N,N)]){
		self.points = numberValues.map { (String($0.0), Double($0.1)) }
		self.valuesGiven = true
	}

	public func onlyPoints() -> [Double] {
		return self.points.map { $0.1 }
	}
}

public struct Styles {
	public static let lineChartStyleOne = ChartStyle(
		backgroundColor: Color.white,
		accentColor: Color.orangeStart,
		secondGradientColor: Color.orangeEnd,
		textColor: Color.black,
		legendTextColor: Color.gray,
		dropShadowColor: Color.gray)

	public static let lineViewDarkMode = ChartStyle(
		backgroundColor: Color.black,
		accentColor: Color.orangeStart,
		secondGradientColor: Color.orangeEnd,
		textColor: Color.white,
		legendTextColor: Color.white,
		dropShadowColor: Color.gray)
}

public struct MagnifierRect: View {
	@Binding var currentNumber: Double
	var valueSpecifier:String
	@Environment(\.colorScheme) var colorScheme: ColorScheme
	public var body: some View {
		ZStack{
			Text("\(self.currentNumber, specifier: valueSpecifier)")
				.font(.system(size: 18, weight: .bold))
				.offset(x: 0, y:-110)
				.foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
			if (self.colorScheme == .dark ){
				RoundedRectangle(cornerRadius: 16)
					.stroke(Color.white, lineWidth: self.colorScheme == .dark ? 2 : 0)
					.frame(width: 60, height: 260)
			}else{
				RoundedRectangle(cornerRadius: 16)
					.frame(width: 60, height: 280)
					.foregroundColor(Color.white)
					.shadow(color: Color.orangeEnd, radius: 12, x: 0, y: 6 )
					.blendMode(.multiply)
			}
		}
		.offset(x: 0, y: -15)
	}
}

extension Color {
	init(hexString: String) {
		let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
		var int = UInt64()
		Scanner(string: hex).scanHexInt64(&int)
		let r, g, b: UInt64
		switch hex.count {
		case 3: // RGB (12-bit)
			(r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
		case 6: // RGB (24-bit)
			(r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
		case 8: // ARGB (32-bit)
			(r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
		default:
			(r, g, b) = (0, 0, 0)
		}
		self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
	}

	static let orangeEnd = Color(hexString: "#FF782C")
	static let orangeStart = Color(hexString: "#EC2301")
	static let legendText = Color(hexString: "#A7A6A8")
	static let legendColor = Color(hexString: "#E8E7EA")
	static let legendDarkColor = Color(hexString: "#545454")
	static let gradientPurple = Color(hexString: "#7B75FF")
	static let gradientNeonBlue = Color(hexString: "#6FEAFF")
	static let gradientUpperBlue = Color(hexString: "#C2E8FF")
	static let indicatorKnob = Color(hexString: "#FF57A6")
}

extension Path {
	var length: CGFloat {
		var ret: CGFloat = 0.0
		var start: CGPoint?
		var point = CGPoint.zero
		
		forEach { ele in
			switch ele {
			case .move(let to):
				if start == nil {
					start = to
				}
				point = to
			case .line(let to):
				ret += point.line(to: to)
				point = to
			case .quadCurve(let to, let control):
				ret += point.quadCurve(to: to, control: control)
				point = to
			case .curve(let to, let control1, let control2):
				ret += point.curve(to: to, control1: control1, control2: control2)
				point = to
			case .closeSubpath:
				if let to = start {
					ret += point.line(to: to)
					point = to
				}
				start = nil
			}
		}
		return ret
	}

	func point(to maxX: CGFloat) -> CGPoint {
		let total = length
		let sub = length(to: maxX)
		let percent = sub / total
		return point(for: percent)
	}

	func point(for percent: CGFloat) -> CGPoint {
		let path = trimmedPath(for: percent)
		return CGPoint(x: path.boundingRect.midX, y: path.boundingRect.midY)
	}

	func trimmedPath(for percent: CGFloat) -> Path {
		// percent difference between points
		let boundsDistance: CGFloat = 0.001
		let completion: CGFloat = 1 - boundsDistance
		
		let pct = percent > 1 ? 0 : (percent < 0 ? 1 : percent)
		
		let start = pct > completion ? completion : pct - boundsDistance
		let end = pct > completion ? 1 : pct + boundsDistance
		return trimmedPath(from: start, to: end)
	}

	func length(to maxX: CGFloat) -> CGFloat {
		var ret: CGFloat = 0.0
		var start: CGPoint?
		var point = CGPoint.zero
		var finished = false
		
		forEach { ele in
			if finished {
				return
			}
			switch ele {
			case .move(let to):
				if to.x > maxX {
					finished = true
					return
				}
				if start == nil {
					start = to
				}
				point = to
			case .line(let to):
				if to.x > maxX {
					finished = true
					ret += point.line(to: to, x: maxX)
					return
				}
				ret += point.line(to: to)
				point = to
			case .quadCurve(let to, let control):
				if to.x > maxX {
					finished = true
					ret += point.quadCurve(to: to, control: control, x: maxX)
					return
				}
				ret += point.quadCurve(to: to, control: control)
				point = to
			case .curve(let to, let control1, let control2):
				if to.x > maxX {
					finished = true
					ret += point.curve(to: to, control1: control1, control2: control2, x: maxX)
					return
				}
				ret += point.curve(to: to, control1: control1, control2: control2)
				point = to
			case .closeSubpath:
				fatalError("Can't include closeSubpath")
			}
		}
		return ret
	}

	static func quadClosedCurvedPathWithPoints(points:[Double], step:CGPoint, globalOffset: Double? = nil) -> Path {
		var path = Path()
		if (points.count < 2){
			return path
		}
		let offset = globalOffset ?? points.min()!

		path.move(to: .zero)
		var p1 = CGPoint(x: 0, y: CGFloat(points[0]-offset)*step.y)
		path.addLine(to: p1)
		for pointIndex in 1..<points.count {
			let p2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y*CGFloat(points[pointIndex]-offset))
			let midPoint = CGPoint.midPointForPoints(p1: p1, p2: p2)
			path.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p1))
			path.addQuadCurve(to: p2, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p2))
			p1 = p2
		}
		path.addLine(to: CGPoint(x: p1.x, y: 0))
		path.closeSubpath()
		return path
	}
	
	static func linePathWithPoints(points:[Double], step:CGPoint) -> Path {
		var path = Path()
		if (points.count < 2){
			return path
		}
		guard let offset = points.min() else { return path }
		let p1 = CGPoint(x: 0, y: CGFloat(points[0]-offset)*step.y)
		path.move(to: p1)
		for pointIndex in 1..<points.count {
			let p2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y*CGFloat(points[pointIndex]-offset))
			path.addLine(to: p2)
		}
		return path
	}
	
	static func closedLinePathWithPoints(points:[Double], step:CGPoint) -> Path {
		var path = Path()
		if (points.count < 2){
			return path
		}
		guard let offset = points.min() else { return path }
		var p1 = CGPoint(x: 0, y: CGFloat(points[0]-offset)*step.y)
		path.move(to: p1)
		for pointIndex in 1..<points.count {
			p1 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y*CGFloat(points[pointIndex]-offset))
			path.addLine(to: p1)
		}
		path.addLine(to: CGPoint(x: p1.x, y: 0))
		path.closeSubpath()
		return path
	}

	static func quadCurvedPathWithPoints(points:[Double], step:CGPoint, globalOffset: Double? = nil) -> Path {
		var path = Path()
		if (points.count < 2){
			return path
		}
		let offset = globalOffset ?? points.min()!
//        guard let offset = points.min() else { return path }
		var p1 = CGPoint(x: 0, y: CGFloat(points[0]-offset)*step.y)
		path.move(to: p1)
		for pointIndex in 1..<points.count {
			let p2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y*CGFloat(points[pointIndex]-offset))
			let midPoint = CGPoint.midPointForPoints(p1: p1, p2: p2)
			path.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p1))
			path.addQuadCurve(to: p2, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p2))
			p1 = p2
		}
		return path
	}
}

extension CGPoint {
	//
	func point(to: CGPoint, x: CGFloat) -> CGPoint {
		let a = (to.y - self.y) / (to.x - self.x)
		let y = self.y + (x - self.x) * a
		return CGPoint(x: x, y: y)
	}

	//
	func line(to: CGPoint) -> CGFloat {
		dist(to: to)
	}

	func line(to: CGPoint, x: CGFloat) -> CGFloat {
		dist(to: point(to: to, x: x))
	}

	func quadCurve(to: CGPoint, control: CGPoint) -> CGFloat {
		var dist: CGFloat = 0
		let steps: CGFloat = 100

		for i in 0..<Int(steps) {
			let t0 = CGFloat(i) / steps
			let t1 = CGFloat(i+1) / steps
			let a = point(to: to, t: t0, control: control)
			let b = point(to: to, t: t1, control: control)

			dist += a.line(to: b)
		}
		return dist
	}

	func quadCurve(to: CGPoint, control: CGPoint, x: CGFloat) -> CGFloat {
		var dist: CGFloat = 0
		let steps: CGFloat = 100

		for i in 0..<Int(steps) {
			let t0 = CGFloat(i) / steps
			let t1 = CGFloat(i+1) / steps
			let a = point(to: to, t: t0, control: control)
			let b = point(to: to, t: t1, control: control)

			if a.x >= x {
				return dist
			} else if b.x > x {
				dist += a.line(to: b, x: x)
				return dist
			} else if b.x == x {
				dist += a.line(to: b)
				return dist
			}

			dist += a.line(to: b)
		}
		return dist
	}

	func point(to: CGPoint, t: CGFloat, control: CGPoint) -> CGPoint {
		let x = CGPoint.value(x: self.x, y: to.x, t: t, c: control.x)
		let y = CGPoint.value(x: self.y, y: to.y, t: t, c: control.y)

		return CGPoint(x: x, y: y)
	}

	func curve(to: CGPoint, control1: CGPoint, control2: CGPoint) -> CGFloat {
		var dist: CGFloat = 0
		let steps: CGFloat = 100

		for i in 0..<Int(steps) {
			let t0 = CGFloat(i) / steps
			let t1 = CGFloat(i+1) / steps

			let a = point(to: to, t: t0, control1: control1, control2: control2)
			let b = point(to: to, t: t1, control1: control1, control2: control2)

			dist += a.line(to: b)
		}

		return dist
	}

	func curve(to: CGPoint, control1: CGPoint, control2: CGPoint, x: CGFloat) -> CGFloat {
		var dist: CGFloat = 0
		let steps: CGFloat = 100

		for i in 0..<Int(steps) {
			let t0 = CGFloat(i) / steps
			let t1 = CGFloat(i+1) / steps

			let a = point(to: to, t: t0, control1: control1, control2: control2)
			let b = point(to: to, t: t1, control1: control1, control2: control2)

			if a.x >= x {
				return dist
			} else if b.x > x {
				dist += a.line(to: b, x: x)
				return dist
			} else if b.x == x {
				dist += a.line(to: b)
				return dist
			}
			dist += a.line(to: b)
		}
		return dist
	}

	func point(to: CGPoint, t: CGFloat, control1: CGPoint, control2: CGPoint) -> CGPoint {
		let x = CGPoint.value(x: self.x, y: to.x, t: t, c1: control1.x, c2: control2.x)
		let y = CGPoint.value(x: self.y, y: to.y, t: t, c1: control1.y, c2: control2.x)
		return CGPoint(x: x, y: y)
	}

	static func value(x: CGFloat, y: CGFloat, t: CGFloat, c: CGFloat) -> CGFloat {
		var value: CGFloat = 0.0
		value += pow(1-t, 2) * x
		value += 2 * (1-t) * t * c
		value += pow(t, 2) * y
		return value
	}
	
	static func value(x: CGFloat, y: CGFloat, t: CGFloat, c1: CGFloat, c2: CGFloat) -> CGFloat {
		var value: CGFloat = 0.0
		value += pow(1-t, 3) * x
		value += 3 * pow(1-t, 2) * t * c1
		value += 3 * (1-t) * pow(t, 2) * c2
		value += pow(t, 3) * y
		return value
	}

	func dist(to: CGPoint) -> CGFloat {
		return sqrt((pow(self.x - to.x, 2) + pow(self.y - to.y, 2)))
	}
	
	static func midPointForPoints(p1:CGPoint, p2:CGPoint) -> CGPoint {
		return CGPoint(x:(p1.x + p2.x) / 2,y: (p1.y + p2.y) / 2)
	}

	static func controlPointForPoints(p1:CGPoint, p2:CGPoint) -> CGPoint {
		var controlPoint = CGPoint.midPointForPoints(p1:p1, p2:p2)
		let diffY = abs(p2.y - controlPoint.y)

		if p1.y < p2.y {
			controlPoint.y += diffY
		} else if p1.y > p2.y {
			controlPoint.y -= diffY
		}
		return controlPoint
	}
}
