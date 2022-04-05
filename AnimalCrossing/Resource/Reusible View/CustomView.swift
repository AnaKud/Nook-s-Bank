// CustomView.swift
// Created by Anastasiya Kudasheva on 29.06.2021.

import UIKit

class CustomView {
	private let colorSet: ColorSet?

	@available(*, deprecated, message: "CustomView is deprecated")
	init(for screen: Screen?) {
		self.colorSet = ColorSet(for: screen)
	}

	@available(*, deprecated, message: "CustomView is deprecated")
	init(colorSet: ColorSet?) {
		self.colorSet = colorSet
	}

	func setupTopView(text: String, _ firstCharacter: String) -> UIView {
		let topView = UIView()
		topView.snp.makeConstraints { make in
			make.height.equalTo(AppContraints.CellSizes.topViewHeight)
		}
		topView.backgroundColor = self.colorSet?.cellColorSet.topViewColor

		let circleView = CircleView(size: AppContraints.CellSizes.circleViewSize,
									firstCharacter: firstCharacter,
									colorSet: self.colorSet)
		topView.addSubview(circleView)
		circleView.snp.makeConstraints { make in
			make.leading.equalTo(topView).offset(AppContraints.CellSizes.cellBgEdge)
			make.centerY.equalTo(topView)
			make.height.width.equalTo(AppContraints.CellSizes.circleViewSize)
		}
		let label = UILabel()
		topView.addSubview(label)
		label.snp.makeConstraints { make in
			make.leading.equalTo(circleView.snp.trailing).offset(AppContraints.CellSizes.cellBgEdge)
			make.trailing.equalTo(topView).offset(-AppContraints.CellSizes.cellBgEdge)
			make.top.equalTo(topView).offset(AppContraints.CellSizes.cellBgEdge)
			make.bottom.equalTo(topView).offset(-AppContraints.CellSizes.cellBgEdge)
		}
		label.text = text
		label.font = ACFont.topViewFont.font
		label.textColor = self.colorSet?.cellColorSet.titleTextColor
		return topView
	}

	func makeImageLeftViewTF(withImageName imageName: String) -> UIView {
		let viewWithImage = UIView()
		guard let image = UIImage(systemName: imageName) else { return viewWithImage }

		let imageView = UIImageView(image: image)
		imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
		imageView.tintColor = self.colorSet?.textfieldColor.imageColor
		viewWithImage.addSubview(imageView)
		imageView.snp.makeConstraints { make in
			make.top.leading.equalTo(viewWithImage).offset(AppContraints.Login.imageLeftViewTF)
			make.bottom.trailing.equalTo(viewWithImage).offset(-AppContraints.Login.imageLeftViewTF)
		}
		return viewWithImage
	}
}
