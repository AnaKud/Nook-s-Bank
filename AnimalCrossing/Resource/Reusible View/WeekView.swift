// WeekView.swift
// Created by Anastasiya Kudasheva on 05.07.2021.

import UIKit

class WeekView: UIView {
	static func setupWeekView(weekDayText: String?, colors: ColorSet?) -> UIView {
		let mainView = UIView()
		let label = UILabel()

		mainView.backgroundColor = colors?.cellColorSet.topViewColor
		mainView.layer.cornerRadius = AppContraints.Turnip.cornerRadius
		mainView.layer.masksToBounds = true

		mainView.addSubview(label)
		label.snp.makeConstraints { make in
			make.leading.top.bottom.equalTo(mainView)
			make.trailing.equalTo(mainView).offset(-AppContraints.minEdge)
		}
		label.text = weekDayText
		label.font = ACFont.weekViewFont.font
		label.textColor = colors?.cellColorSet.titleTextColor
		label.textAlignment = .right
		return mainView
	}
}
