// RegisterUserView.swift
// Created by Anastasiya Kudasheva on 13.08.2021.

import KeyboardListener
import UIKit

protocol IRegisterUserButtonCallback {
	func registerUserButtonTapped(_ user: NewUserViewModel)
}

class RegisterUserView: UIView {
	private var callback: IRegisterUserButtonCallback
	var avatarNameHandler: String?

	private var colors = ColorSet(for: .mainScreen(.additionalScreen))

	private var scrollView = UIScrollView()
	private var contentView = UIView()
	private var avatarCollectionView = UICollectionView(frame: .zero,
														collectionViewLayout: UICollectionViewLayout())
	private var nameLabel = UILabel()
	private lazy var nameTextField = CustomTextField(settings: CustomTextField.Settings(
		color: self.colors,
		cornerRadius: AppContraints.Settings.cornerRadiusTF,
		placeholder: "Add your name"))
	private var emailLabel = UILabel()
	private lazy var emailTextField = CustomTextField(settings: CustomTextField.Settings(
		color: self.colors,
		cornerRadius: AppContraints.Settings.cornerRadiusTF,
		placeholder: "Add your email",
		isEditable: true))
	private var passwordEmailLabel = UILabel()
	private lazy var passwordEmailTextField = CustomTextField(settings: CustomTextField.Settings(
		color: self.colors,
		cornerRadius: AppContraints.Settings.cornerRadiusTF,
		placeholder: "Password. 6 characters minimum",
		isSecureTextEntry: true))
	private lazy var passwordEmailCheckingTextField = CustomTextField(settings: CustomTextField.Settings(
		color: self.colors,
		cornerRadius: AppContraints.Settings.cornerRadiusTF,
		placeholder: "Repeat password",
		isSecureTextEntry: true))
	private var padSectionLabel = UILabel()
	private var padLabel = UILabel()
	private lazy var padSwitcher = CustomSwitcher(color: self.colors)
	private var padPasswordLabel = UILabel()
	private lazy var newPadTextField = CustomTextField(settings: CustomTextField.Settings(
		color: self.colors,
		cornerRadius: AppContraints.Settings.cornerRadiusTF,
		placeholder: "6 numbers",
		isSecureTextEntry: true))
	private lazy var newPadCheckingTextField = CustomTextField(settings: CustomTextField.Settings(
		color: self.colors,
		cornerRadius: AppContraints.Settings.cornerRadiusTF,
		placeholder: "Repeat password",
		isSecureTextEntry: true))
	private var registerButton = UIButton()

	private var observer: IKeyboardObserver?

	init(callback: IRegisterUserButtonCallback) {
		self.callback = callback
		super.init(frame: .zero)
		self.loadUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension RegisterUserView: IKeyboardListener {
	var viewChanger: IViewChanger { ViewChanger(view: self.contentView) }
}

private extension RegisterUserView {
	func loadUI() {
		self.observer = KeyboardObserver(for: self)
		self.setupScrollView()
		self.setupAvatarView()
		self.setupNameSection()
		self.setupEmailSection()
		self.setupEmailPasswordSection()
		self.setupPadSection()
		self.setupRegisterButton()
	}

	func setupScrollView() {
		self.addSubview(self.scrollView)
		self.scrollView.snp.makeConstraints { make in
			make.edges.equalTo(self)
		}
		self.scrollView.delegate = self
		self.scrollView.addSubview(self.contentView)
		self.contentView.snp.makeConstraints { make in
			make.edges.equalTo(self.scrollView)
			make.width.equalTo(self.snp.width)
		}
		self.scrollView.alwaysBounceVertical = true
		self.scrollView.contentSize = CGSize(width: self.frame.width, height: self.frame.height)
	}

	func setupAvatarView() {
		self.contentView.addSubview(avatarCollectionView)
		self.collectionViewSettings()
		self.avatarCollectionView.snp.makeConstraints { make in
			make.top.equalTo(self.contentView).offset(AppContraints.standartEdge)
			make.centerX.equalTo(self.contentView)
			make.height.width.equalTo(AppContraints.Settings.avatarHeight)
		}

		self.avatarCollectionView.layer.borderColor = self.colors.segmentedControlColor.borderColor
		self.avatarCollectionView.layer.borderWidth = 2
		self.avatarCollectionView.layer.cornerRadius = AppContraints.standartCornerRadius
		self.avatarCollectionView.layer.masksToBounds = true
	}

	func setupNameSection() {
		self.nameLabel.text = "Name"
		self.nameLabel.textColor = self.colors.mainViewColor.textColor
		self.nameLabel.font = ACFont.defaultBoldFont.font
		self.contentView.addSubview(self.nameLabel)
		self.nameLabel.snp.makeConstraints { make in
			make.top.equalTo(self.avatarCollectionView.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.width.equalTo(AppContraints.Settings.widthUserLabel)
		}
		self.contentView.addSubview(self.nameTextField)
		self.nameTextField.snp.makeConstraints { make in
			make.top.equalTo(self.avatarCollectionView.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.nameLabel.snp.trailing).offset(AppContraints.midEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
		self.nameTextField.delegate = self
	}

	func setupEmailSection() {
		self.emailLabel.text = "Email"
		self.emailLabel.textColor = self.colors.mainViewColor.textColor
		self.emailLabel.font = ACFont.defaultBoldFont.font
		self.contentView.addSubview(self.emailLabel)
		self.emailLabel.snp.makeConstraints { make in
			make.top.equalTo(self.nameTextField.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.width.equalTo(AppContraints.Settings.widthUserLabel)
		}
		self.contentView.addSubview(self.emailTextField)
		self.emailTextField.snp.makeConstraints { make in
			make.top.equalTo(self.nameTextField.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.emailLabel.snp.trailing).offset(AppContraints.midEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
		self.emailTextField.delegate = self
	}

	func setupEmailPasswordSection() {
		self.passwordEmailLabel.text = "Email Password"
		self.passwordEmailLabel.textAlignment = .center
		self.passwordEmailLabel.textColor = self.colors.mainViewColor.textColor
		self.passwordEmailLabel.font = ACFont.defaultBoldFont.font
		self.contentView.addSubview(self.passwordEmailLabel)
		self.passwordEmailLabel.snp.makeConstraints { make in
			make.top.equalTo(self.emailTextField.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
		}
		self.setupPasswordFields()
	}

	func setupPadSection() {
		self.padSectionLabel.numberOfLines = 0
		self.padSectionLabel.text = "Simple login with number code"
		self.padSectionLabel.textAlignment = .center
		self.padSectionLabel.textColor = self.colors.mainViewColor.textColor
		self.padSectionLabel.font = ACFont.defaultBoldFont.font
		self.contentView.addSubview(self.padSectionLabel)
		self.padSectionLabel.snp.makeConstraints { make in
			make.top.equalTo(self.passwordEmailCheckingTextField.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
		}
		self.contentView.addSubview(self.padSwitcher)
		self.padSwitcher.snp.makeConstraints { make in
			make.top.equalTo(self.padSectionLabel.snp.bottom).offset(AppContraints.midEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
		}
		self.padSwitcher.addTarget(self, action: #selector(self.padSwitcherValueChanged), for: .valueChanged)
		self.padLabel.text = "Use number code"
		self.padLabel.textColor = self.colors.mainViewColor.textColor
		self.padLabel.font = ACFont.defaultBoldFont.font
		self.contentView.addSubview(self.padLabel)
		self.padLabel.snp.makeConstraints { make in
			make.centerY.equalTo(self.padSwitcher)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.padSwitcher.snp.leading)
		}
		self.setupPadTextFields()
	}

	func setupRegisterButton() {
		self.registerButton = OvalButton(withTitle: "Register",
										 width: AppContraints.Login.widthButton,
										 height: AppContraints.Login.heightButtons,
										 color: self.colors)
		self.contentView.addSubview(self.registerButton)
		self.makeButtonConstraintsForOffSwithcer()
		self.registerButton.addTarget(self, action: #selector(self.registerButtonTapped), for: .touchUpInside)
		self.registerButton.snp.makeConstraints { make in
			make.top.equalTo(self.newPadCheckingTextField.snp.bottom).offset(AppContraints.standartEdge)
			make.centerX.equalToSuperview()
			make.height.equalTo(AppContraints.Login.heightButtons)
			make.width.equalTo(AppContraints.Login.widthButton)
			make.bottom.greaterThanOrEqualTo(self.contentView.snp.bottom)
		}
	}

	func makeButtonConstraintsForOnSwithcer() {
		self.newPadTextField.makeEditable()
		self.newPadCheckingTextField.makeEditable()
	}

	func makeButtonConstraintsForOffSwithcer() {
		self.newPadTextField.makeUneditable()
		self.newPadCheckingTextField.makeUneditable()
		self.newPadTextField.text?.removeAll()
		self.newPadCheckingTextField.text?.removeAll()
	}
}

@objc
private extension RegisterUserView {
	func padSwitcherValueChanged() {
		self.changePadTFVisability(self.padSwitcher.isOn)
	}

	func registerButtonTapped() {
			let newUser = NewUserViewModel(name: self.nameTextField.text,
										   avatar: self.avatarNameHandler,
										   email: self.emailTextField.text,
										   emailPassword: self.passwordEmailTextField.text,
										   repetedEmailPassword: self.passwordEmailCheckingTextField.text,
										   padAvailaible: self.padSwitcher.isOn,
										   pad: self.newPadTextField.text,
										   repetedPad: self.newPadCheckingTextField.text)
			self.callback.registerUserButtonTapped(newUser)
	}
}

private extension RegisterUserView {
	func collectionViewSettings() {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .horizontal
		flowLayout.minimumLineSpacing = 5
		flowLayout.itemSize = CGSize(width: AppContraints.Settings.avatarHeight,
									 height: AppContraints.Settings.avatarHeight)
		self.avatarCollectionView.collectionViewLayout = flowLayout
		self.avatarCollectionView.backgroundColor = .clear
		self.avatarCollectionView.delegate = self
		self.avatarCollectionView.dataSource = self
		self.avatarCollectionView.register(AvatarCollectionViewCell.self,
										   forCellWithReuseIdentifier: CellReusibleID.avatarRegister.rawValue)
	}
}

private extension RegisterUserView {
	func setupPasswordFields() {
		self.contentView.addSubview(self.passwordEmailTextField)
		self.passwordEmailTextField.snp.makeConstraints { make in
			make.top.equalTo(self.passwordEmailLabel.snp.bottom).offset(AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
		self.contentView.addSubview(self.passwordEmailCheckingTextField)
		self.passwordEmailCheckingTextField.snp.makeConstraints { make in
			make.top.equalTo(self.passwordEmailTextField.snp.bottom).offset(AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
		self.passwordEmailTextField.delegate = self
		self.passwordEmailCheckingTextField.delegate = self
	}
}

private extension RegisterUserView {
	func changePadTFVisability(_ visible: Bool) {
		if visible {
			self.makeButtonConstraintsForOnSwithcer()
		} else {
			self.makeButtonConstraintsForOffSwithcer()
		}
	}

	func setupPadTextFields() {
		self.newPadTextField.keyboardType = .numberPad
		self.contentView.addSubview(self.newPadTextField)
		self.newPadTextField.snp.makeConstraints { make in
			make.top.equalTo(self.padLabel.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
		self.newPadCheckingTextField.keyboardType = .numberPad
		self.contentView.addSubview(self.newPadCheckingTextField)
		self.newPadCheckingTextField.snp.makeConstraints { make in
			make.top.equalTo(self.newPadTextField.snp.bottom).offset(AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
		self.newPadTextField.delegate = self
		self.newPadCheckingTextField.delegate = self
	}
}

extension RegisterUserView: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		if textField == self.nameTextField
			|| textField == self.emailTextField
			|| textField == self.passwordEmailTextField {
			self.observer?.stopObserve()
		} else {
			self.observer?.startObserve()
		}
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}

	func textField(
		_ textField: UITextField,
		shouldChangeCharactersIn range: NSRange,
		replacementString string: String
	) -> Bool {
		guard (textField == self.newPadTextField || textField == self.newPadCheckingTextField),
			  let textFieldText = textField.text,
			let rangeOfTextToReplace = Range(range, in: textFieldText) else {
			return true
		}
		let substringToReplace = textFieldText[rangeOfTextToReplace]
		let count = textFieldText.count - substringToReplace.count + string.count
		return (count) <= 6
	}
}
