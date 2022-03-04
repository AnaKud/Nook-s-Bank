// CircleView.swift
// Created by Anastasiya Kudasheva on 02.09.2021.

import UIKit

final class CircleView: UIView {
	private var circleViewSize: CGFloat
	private var firstCharacter: String
	private var colorSet: ColorSet.CircleViewColor

	init(size: CGFloat, firstCharacter: String, screenType: ScreenTypes = .other) {
		self.circleViewSize = size
		self.firstCharacter = firstCharacter
		self.colorSet = ColorSet(for: screenType).circleViewColor
		super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
		self.setupLayouts()
	}

	init(size: CGFloat, firstCharacter: String, colorSet: ColorSet?) {
		self.circleViewSize = size
		self.firstCharacter = firstCharacter
		self.colorSet = colorSet?.circleViewColor ?? ColorSet(for: .other).circleViewColor
		super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
		self.setupLayouts()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
private extension CircleView {
	func setupLayouts() {
		//	self.translatesAutoresizingMaskIntoConstraints = false
		let circleLabel = self.makeCircleLabel()
		//	circleLabel.translatesAutoresizingMaskIntoConstraints = false

		self.layer.cornerRadius = self.circleViewSize / 2
		self.backgroundColor = self.colorSet.circleColor
		self.addSubview(circleLabel)
		circleLabel.snp.makeConstraints { make in
			make.edges.equalTo(self)
		}
		self.layer.masksToBounds = true
	}

	func makeCircleLabel() -> UILabel {
		let label = UILabel()
		label.text = self.firstCharacter
		label.font = ACFont.defaultBoldFont.font
		label.textColor = self.colorSet.circleTextColor
		label.textAlignment = .center
		return label
	}
}
