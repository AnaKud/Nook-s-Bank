//
//  CustomTextField.swift
//  Created by Anastasiya Kudasheva on 08.09.2021

import UIKit

class CustomTextField: UITextField {
	struct Settings {
		var color: ColorSet.TextFieldColor
		var cornerRadius: CGFloat
		var placeholder: String
		var text: String?
		var systemImageName: String?
		var isSecureTextEntry: Bool
		var isEditable: Bool

		init(
			color: ColorSet,
			cornerRadius: CGFloat,
			placeholder: String = "",
			text: String? = nil,
			systemImageName: String? = nil,
			isSecureTextEntry: Bool = false,
			isEditable: Bool = true
		) {
			self.color = color.textfieldColor
			self.cornerRadius = cornerRadius
			self.placeholder = placeholder
			self.text = text
			self.systemImageName = systemImageName
			self.isSecureTextEntry = isSecureTextEntry
			self.isEditable = isEditable
		}
	}

	init(settings: CustomTextField.Settings) {
		super.init(frame: .zero)
		self.setupUI(settings: settings)
		self.delegate = self
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupUI(settings: CustomTextField.Settings) {
		if let settingsText = settings.text, !settingsText.isEmpty {
			self.text = settingsText
		}
		if !settings.placeholder.isEmpty {
			self.placeholder = settings.placeholder
		}
		self.isSecureTextEntry = settings.isSecureTextEntry
		self.font = ACFont.defaultLightFont.font 
		self.textColor = settings.color.textColor
		self.layer.cornerRadius = settings.cornerRadius
		self.layer.borderColor = settings.color.borderColor
		self.layer.borderWidth = AppContraints.defaultBorder
		self.isUserInteractionEnabled = settings.isEditable
		self.backgroundColor = settings.color.backgroundColor
		self.leftViewMode = .always
		var leftView = UIView(frame: CGRect(x: 0, y: 0, width: AppContraints.minEdge, height: self.frame.height))
		if let imageName = settings.systemImageName {
			leftView = self.makeImageLeftViewTF(withImageName: imageName,
												tintColor: settings.color.imageColor)
		}
		self.leftView = leftView
		self.rightViewMode = .always
		self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: AppContraints.minEdge, height: self.frame.height))
		self.layer.masksToBounds = true
	}

	private func makeImageLeftViewTF(withImageName imageName: String, tintColor: UIColor?) -> UIView {
		let viewWithImage = UIView()
		guard let image = UIImage(systemName: imageName) else { return viewWithImage }

		let imageView = UIImageView(image: image)
		imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
		imageView.tintColor = tintColor
		viewWithImage.addSubview(imageView)
		imageView.snp.makeConstraints { make in
			make.top.leading.equalTo(viewWithImage).offset(AppContraints.Login.imageLeftViewTF)
			make.bottom.trailing.equalTo(viewWithImage).offset(-AppContraints.Login.imageLeftViewTF)
		}
		return viewWithImage
	}
}

extension CustomTextField: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return self.endEditing(false)
	}
}
