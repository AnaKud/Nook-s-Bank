// CustomTextField.swift
// Created by Anastasiya Kudasheva on 08.09.2021

import UIKit

class CustomTextField: UITextField {
	struct Settings {
		var color: ColorSet.TextFieldColor
		var cornerRadius: CGFloat
		var placeholder: String
		var text: String?
		var image: UIImage?
		var isSecureTextEntry: Bool
		var isEditable: Bool

		init(
			color: ColorSet,
			cornerRadius: CGFloat,
			placeholder: String = "",
			text: String? = nil,
			image: UIImage? = nil,
			isSecureTextEntry: Bool = false,
			isEditable: Bool = true
		) {
			self.color = color.textfieldColor
			self.cornerRadius = cornerRadius
			self.placeholder = placeholder
			self.text = text
			self.image = image
			self.isSecureTextEntry = isSecureTextEntry
			self.isEditable = isEditable
		}
	}

	private var settings: CustomTextField.Settings

	init(settings: CustomTextField.Settings) {
		self.settings = settings
		super.init(frame: .zero)
		self.setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupUI() {
		if let settingsText = self.settings.text,
		   !settingsText.isEmpty {
			self.text = settingsText
		}
		if !self.settings.placeholder.isEmpty {
			self.placeholder = self.settings.placeholder
		}
		self.isSecureTextEntry = self.settings.isSecureTextEntry
		self.font = ACFont.defaultLightFont.font
		self.textColor = self.settings.color.textColor
		self.layer.cornerRadius = self.settings.cornerRadius
		self.layer.borderColor = self.settings.color.borderColor
		self.layer.borderWidth = AppContraints.defaultBorder
		self.isUserInteractionEnabled = self.settings.isEditable
		self.backgroundColor = self.settings.color.backgroundColor
		self.leftViewMode = .always
		var leftView = UIView(frame: CGRect(x: 0, y: 0, width: AppContraints.minEdge, height: self.frame.height))
		if let image = self.settings.image {
			leftView = self.makeImageLeftViewTF(withImage: image,
												tintColor: self.settings.color.imageColor)
		}
		self.leftView = leftView
		self.rightViewMode = .always
		self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: AppContraints.minEdge, height: self.frame.height))
		self.layer.masksToBounds = true
	}

	private func makeImageLeftViewTF(withImage image: UIImage, tintColor: UIColor?) -> UIView {
		let viewWithImage = UIView()
		image.withRenderingMode(.alwaysTemplate)
		let imageView = UIImageView(image: image)
		imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
		imageView.tintColor = tintColor
		viewWithImage.addSubview(imageView)
		imageView.snp.makeConstraints { make in
			make.top.equalTo(viewWithImage).offset(AppContraints.Login.imageLeftViewTF)
			make.bottom.equalTo(viewWithImage).offset(-AppContraints.Login.imageLeftViewTF)
			make.leading.equalTo(viewWithImage).offset(AppContraints.minEdge)
			make.trailing.equalTo(viewWithImage).offset(-AppContraints.minEdge)
		}
		return viewWithImage
	}
}

extension CustomTextField {
	func makeEditable() {
		self.isEnabled = true
		self.backgroundColor = self.settings.color.backgroundColor
	}

	func makeUneditable() {
		self.isEnabled = false
		self.backgroundColor = self.settings.color.uneditableBackgroundColor
	}
}
