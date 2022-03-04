// OvalButton.swift
// Created by Anastasiya Kudasheva on 02.09.2021.

import UIKit

class OvalButton: UIButton {
	private var title: String
	private var color: ColorSet
	private var height: CGFloat

	private var circleViewSize: CGFloat = 0
	private var circleEdges: CGFloat = 0
	private var firstCharacter: String = ""
	private var circleView = UIView()

	required init(withTitle title: String, width: CGFloat, height: CGFloat, color: ColorSet) {
		self.title = title
		self.color = color
		self.height = height
		super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
		self.calculateSettings()
		self.setupLayouts()
	}

	init(withTitle title: String, width: CGFloat, height: CGFloat, color: ColorSet?) {
		self.title = title
		self.color = color ?? ColorSet(for: .other)
		self.height = height
		super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
		self.calculateSettings()
		self.setupLayouts()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension OvalButton {
	func setupLayouts() {
		self.layer.cornerRadius = self.height / 2
		self.backgroundColor = self.color.ovalButtonColor.buttonColor
		//	self.translatesAutoresizingMaskIntoConstraints = false
		self.addCircleView()
		self.addTitleLabel()
	}

	func calculateSettings() {
		self.circleViewSize = self.height * 0.7
		self.circleEdges = (self.height - self.circleViewSize) / 2
		self.firstCharacter = "\(self.title.first ?? "+")"
	}

	func addCircleView() {
		self.circleView = CircleView(size: self.circleViewSize,
									 firstCharacter: self.firstCharacter,
									 colorSet: self.color)
		self.addSubview(self.circleView)
		//	self.circleView.translatesAutoresizingMaskIntoConstraints = false
		//		self.circleView.anchor(top: self.topAnchor,
		//							   leading: self.leadingAnchor,
		//							   bottom: self.bottomAnchor,
		//							   trailing: nil, padding: UIEdgeInsets(top: self.circleEdges,
		//																	left: self.circleEdges,
		//																	bottom: self.circleEdges,
		//																	right: 999),
		//							   size: CGSize(width: self.circleViewSize,
		//											height: self.circleViewSize))
		self.circleView.snp.makeConstraints { make in
			make.top.leading.equalTo(self).offset(self.circleEdges)
			make.centerY.equalTo(self)
			make.height.width.equalTo(self.circleViewSize)
		}
	}

	func addTitleLabel() {
		let titleLabel = UILabel()
		//	titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.text = title
		titleLabel.textColor = self.color.ovalButtonColor.buttonTextColor
		titleLabel.font = ACFont.loginButtonFont.font
		self.addSubview(titleLabel)
		titleLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview()
			make.leading.equalTo(self.circleView.snp.trailing).offset(self.circleEdges)
			make.trailing.equalTo(self).offset(-self.circleEdges)
		}
	}
}
