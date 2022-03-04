// TopView.swift
// Created by Anastasiya Kudasheva on 30.12.2021

import UIKit

class TopView: UIView {
	private var colorSet: ColorSet
	private var text: String
	private var firstCharacter: String
	init(text: String, firstCharacter: String, screenType: ScreenTypes = .other) {
		self.text = text
		self.firstCharacter = firstCharacter
		self.colorSet = ColorSet(for: screenType)
		super.init(frame: .zero)
		self.setupLayouts()
	}

	init(text: String, firstCharacter: String, colorSet: ColorSet?) {
		self.text = text
		self.firstCharacter = firstCharacter
		self.colorSet = colorSet ?? ColorSet(for: .other)
		super.init(frame: .zero)
		self.setupLayouts()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupLayouts() {
		self.backgroundColor = self.colorSet.cellColorSet.topViewColor

		let circleView = CircleView(size: AppContraints.CellSizes.circleViewSize,
									firstCharacter: firstCharacter,
									colorSet: self.colorSet)
		self.addSubview(circleView)
		circleView.snp.makeConstraints { make in
			make.leading.equalTo(self).offset(AppContraints.CellSizes.cellBgEdge)
			make.centerY.equalTo(self)
			make.height.width.equalTo(AppContraints.CellSizes.circleViewSize)
		}
		let label = UILabel()
		self.addSubview(label)
		label.snp.makeConstraints { make in
			make.leading.equalTo(circleView.snp.trailing).offset(AppContraints.CellSizes.cellBgEdge)
			make.trailing.equalTo(self).offset(-AppContraints.CellSizes.cellBgEdge)
			make.top.equalTo(self).offset(AppContraints.CellSizes.cellBgEdge)
			make.bottom.equalTo(self).offset(-AppContraints.CellSizes.cellBgEdge)
		}
		label.text = self.text
		label.font = ACFont.topViewFont.font
		label.textColor = self.colorSet.cellColorSet.titleTextColor
	}
}
