// UIStackView+removeAllSubview.swift
// Created by Anastasiya Kudasheva on 19.03.2022

import UIKit

extension UIStackView {
	func removeAllArrangedSubViews() {
		self.arrangedSubviews.forEach {
			self.removeArrangedSubview($0)
			$0.removeFromSuperview()
		}
	}
}
