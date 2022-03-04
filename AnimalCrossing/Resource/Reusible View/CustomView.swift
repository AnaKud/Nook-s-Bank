// CustomView.swift
// Created by Anastasiya Kudasheva on 29.06.2021.

import UIKit

class CustomView {
	var colorSet: ColorSet?

	init(for screenType: ScreenTypes?) {
		self.colorSet = ColorSet(for: screenType)
	}

	init(colorSet: ColorSet?) {
		self.colorSet = colorSet
	}

	func setupTopView(text: String, _ firstCharacter: String) -> UIView {
		let topView = UIView()
		topView.snp.makeConstraints { make in
			make.height.equalTo(AppContraints.CellSizes.topViewHeight)
		}
		topView.backgroundColor = colorSet?.cellColorSet.topViewColor

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
		label.textColor = colorSet?.cellColorSet.titleTextColor
		return topView
	}

	@available(*, deprecated, message: "makeTextField. Use class")
	func makeTextField(height: CGFloat, cornerRadius: CGFloat, editable: Bool) -> UITextField {
		let textfield = UITextField()
		textfield.font = ACFont.defaultLightFont.font
		textfield.textColor = colorSet?.textfieldColor.textColor
		textfield.layer.cornerRadius = cornerRadius
		textfield.borderStyle = .none
		textfield.isUserInteractionEnabled = editable
		textfield.backgroundColor = colorSet?.textfieldColor.backgroundColor
		textfield.leftViewMode = .always
		textfield.leftView = UIView(frame: CGRect(x: 0,
												  y: 0,
												  width: AppContraints.minEdge,
												  height: textfield.frame.height))
		textfield.rightViewMode = .always
		textfield.rightView = UIView(frame: CGRect(x: 0,
												   y: 0,
												   width: AppContraints.minEdge,
												   height: textfield.frame.height))
		return textfield
	}

	@available(*, deprecated, message: "makeTextField. Use class")

	func makeTextField(
		withPlacehoder placeholder: String = "",
		withText text: String = "",
		height: CGFloat,
		cornerRadius: CGFloat,
		withImage image: UIImage?,
		isSecureTextEntry: Bool = false
	) -> UITextField {
		CustomTextField(settings: CustomTextField.Settings(color: self.colorSet ?? ColorSet(for: .other),
														   cornerRadius: cornerRadius,
														   placeholder: placeholder,
														   text: text,
														   image: image,
														   isSecureTextEntry: isSecureTextEntry,
														   isEditable: true))
		//		let textfield = UITextField()
//		if !text.isEmpty { textfield.text = text }
//		if !placeholder.isEmpty { textfield.placeholder = placeholder }
//		textfield.isSecureTextEntry = isSecureTextEntry
//		textfield.font = ACFont.defaultLightFont.font
//		textfield.textColor = colorSet?.textfieldColor.textColor
//		textfield.layer.cornerRadius = cornerRadius
//		textfield.backgroundColor = colorSet?.textfieldColor.backgroundColor
//		var leftView = UIView()
//		if !imageName.isEmpty {
//			leftView = makeImageLeftViewTF(withImageName: imageName)
//		} else {
//			leftView = UIView(frame: CGRect(x: 0, y: 0,
//											width: AppContraints.midEdge,
//											height: textfield.frame.height))
//		}
//		textfield.leftViewMode = .always
//		textfield.leftView = leftView
//		textfield.snp.makeConstraints { make in
//			make.height.equalTo(height)
//		}
//		textfield.rightViewMode = .always
//		textfield.rightView = UIView(frame: CGRect(x: 0, y: 0,
//												   width: AppContraints.midEdge,
//												   height: textfield.frame.height))
//		return textfield
	}

	func makeImageLeftViewTF(withImageName imageName: String) -> UIView {
		let viewWithImage = UIView()
		guard let image = UIImage(systemName: imageName) else { return viewWithImage }

		let imageView = UIImageView(image: image)
		imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
		imageView.tintColor = colorSet?.textfieldColor.imageColor
		viewWithImage.addSubview(imageView)
		imageView.snp.makeConstraints { make in
			make.top.leading.equalTo(viewWithImage).offset(AppContraints.Login.imageLeftViewTF)
			make.bottom.trailing.equalTo(viewWithImage).offset(-AppContraints.Login.imageLeftViewTF)
		}
		return viewWithImage
	}
}

class DefaultView: UIView {
	private var screenType: ScreenTypes
	var controllerTitle: String?
	lazy var colors: ColorSet = {
		ColorSet(for: screenType)
	}()

	var customView: CustomView {
		CustomView(colorSet: colors)
	}

	let mainView = UIView()
	let topView = UIView()
	let bottomView = UIView()
	let titleLabel = UILabel()
	let contentView = UIView()
	let topImageView = UIImageView()
	let bottomImageView = UIImageView()

	init(controllerTitle: String? = nil, screenType: ScreenTypes = .other) {
		self.controllerTitle = controllerTitle
		self.screenType = screenType
		super.init(frame: .zero)
		self.setupMainView()
		self.setupTopBottomLayout()
		self.setupView()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupMainView() {
		self.addSubview(self.mainView)
		self.mainView.snp.makeConstraints {  make in
			make.top.trailing.leading.bottom.equalToSuperview()
		}
		self.mainView.backgroundColor = self.colors.mainViewColor.backgroundColor
	}

	private func setupTopBottomLayout() {
		self.mainView.addSubview(self.topView)
		self.topView.snp.makeConstraints { make in
			make.top.trailing.leading.equalTo(self.mainView)
			make.height.equalTo(AppContraints.navAndTabHeight)
		}
		self.topView.addSubview(self.topImageView)
		self.topImageView.snp.makeConstraints { make in
			make.top.trailing.leading.bottom.equalTo(self.topView)
		}
		self.mainView.addSubview(self.bottomView)
		self.bottomView.snp.makeConstraints { make in
			make.bottom.trailing.leading.equalTo(self.mainView)
			make.height.equalTo(AppContraints.navAndTabHeight)
		}
		self.bottomView.addSubview(self.bottomImageView)
		self.bottomImageView.snp.makeConstraints { make in
			make.top.trailing.leading.bottom.equalTo(self.bottomView)
		}
		self.mainView.addSubview(self.contentView)
		self.contentView.snp.makeConstraints { make in
			make.trailing.leading.equalTo(self.mainView)
			make.top.equalTo(topView.snp.bottom).offset(AppContraints.minEdge)
			make.bottom.equalTo(bottomView.snp.top).offset(-AppContraints.minEdge)
		}
		self.contentView.backgroundColor = .clear
	}

	private func setupView() {
		self.mainView.backgroundColor = self.colors.mainViewColor.backgroundColor
		self.titleLabel.textColor = self.colors.mainViewColor.textColor
		self.titleLabel.numberOfLines = 0

		switch self.screenType {
		case .loggined:
			self.topImageView.image = UIImage(named: AppImage.TopBottomImage.logTop.rawValue)
			self.bottomImageView.image = UIImage(named: AppImage.TopBottomImage.logBottom.rawValue)

		case .unloggined:
			self.topImageView.image = UIImage(named: AppImage.TopBottomImage.unlogTop.rawValue)
			self.bottomImageView.image = UIImage(named: AppImage.TopBottomImage.unlogBottom.rawValue)
		default:
			self.mainView.backgroundColor = self.colors.mainViewColor.backgroundColor
		}
		if self.screenType != .loginScreen {
			self.mainView.addSubview(self.titleLabel)
			self.titleLabel.snp.makeConstraints { make in
				make.top.equalTo(self.mainView).offset(AppContraints.navTitle)
				make.leading.trailing.equalTo(self.mainView)
			}
			self.titleLabel.text = controllerTitle
			self.titleLabel.textAlignment = .center
			self.titleLabel.font = ACFont.controllerTitleFont.font
		}
	}
}
