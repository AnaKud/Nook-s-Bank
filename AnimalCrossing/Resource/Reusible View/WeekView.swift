// WeekView.swift
// Created by Anastasiya Kudasheva on 05.07.2021.

import UIKit

class WeekView: UIView {
	private let label = UILabel()

	init(text: String?, colors: ColorSet?) {
		super.init(frame: .zero)
		self.setupWeekView(weekDayText: text, colors: colors)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupWeekView(weekDayText: String?, colors: ColorSet?) {
		self.backgroundColor = colors?.cellColorSet.topViewColor
		self.layer.cornerRadius = AppContraints.Turnip.cornerRadius
		self.layer.masksToBounds = true

		self.addSubview(self.label)
		self.label.snp.makeConstraints { make in
			make.leading.top.bottom.equalTo(self)
			make.trailing.equalTo(self).offset(-AppContraints.minEdge)
		}
		self.label.text = weekDayText
		self.label.font = ACFont.weekViewFont.font
		self.label.textColor = colors?.cellColorSet.titleTextColor
		self.label.textAlignment = .right
	}
}
