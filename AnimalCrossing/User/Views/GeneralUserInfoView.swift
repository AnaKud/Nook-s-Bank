//
//  GeneralUserInfoView.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 13.08.2021.
//

import UIKit

class GeneralUserInfoView: UIView {
	var userSettings: UserSettingsViewModel?
	var currentAvatarIcon: AppImage.AvatarIcon?

	lazy var colors = ColorSet(for: .other)

	var scrollView = UIScrollView()
	var contentView = UIView()
	var avatarCollectionView = UICollectionView(frame: .zero,
												collectionViewLayout: UICollectionViewLayout())
	var nameLabel = UILabel()
	var nameTextField = UITextField()
	var emailLabel = UILabel()
	var emailTextField = UITextField()
	var passwordEmailLabel = UILabel()
	var oldPasswordEmailTextField = UITextField()
	var newPasswordEmailTextField = UITextField()
	var newPasswordEmailCheckingTextField = UITextField()

	var padSectionLabel = UILabel()
	var padLabel = UILabel()
	var padSwither = UISwitch()
	var padPasswordLabel = UILabel()
	var oldPadTextField = UITextField()
	var newPadTextField = UITextField()
	var newPadCheckingTextField = UITextField()
	var saveSettingsOrRegisterButton = UIButton()

	init(userSettings: UserSettingsViewModel?) {
		super.init(frame: .zero)
		self.userSettings = userSettings
		self.currentAvatarIcon = AppImage.AvatarIcon(rawValue: self.userSettings?.avatar ?? "Blathers")
		self.loadUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func loadUI() {
		self.setupScrollView()
		self.setupAvatarView()
		self.setupNameSection()
		self.setupEmailSection()
		self.setupEmailPasswordSection()
		self.setupPadSection()
		self.setupSaveSettingsOrRegisterButton()
		self.changePadTFVisability()
	}
}

private extension GeneralUserInfoView {
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
		self.nameTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																				cornerRadius: AppContraints.Settings.cornerRadiusTF,
																				placeholder: "Add your name",
																				text: self.userSettings?.name))
		self.contentView.addSubview(self.nameTextField)
		self.nameTextField.snp.makeConstraints { make in
			make.top.equalTo(self.avatarCollectionView.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.nameLabel.snp.trailing).offset(AppContraints.midEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
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

		let emailEditable = self.userSettings?.settingsType == .register
		self.emailTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																				 cornerRadius: AppContraints.Settings.cornerRadiusTF,
																				 placeholder: "Add your email",
																				 text: self.userSettings?.email,
																				 isEditable: emailEditable))
		self.contentView.addSubview(self.emailTextField)
		self.emailTextField.snp.makeConstraints { make in
			make.top.equalTo(self.nameTextField.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.emailLabel.snp.trailing).offset(AppContraints.midEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
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
			make.top.equalTo(self.newPasswordEmailCheckingTextField.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
		}
		self.padSwither = CustomSwitcher(color: self.colors)
		self.contentView.addSubview(self.padSwither)
		self.padSwither.isOn = self.userSettings?.padCodeExist ?? false
		self.padSwither.snp.makeConstraints { make in
			make.top.equalTo(self.padSectionLabel.snp.bottom).offset(AppContraints.midEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
		}
		self.padSwither.addTarget(self, action: #selector(padSwitcherValueChanged), for: .valueChanged)
		self.padLabel.text = "Use number code"
		self.padLabel.textColor = self.colors.mainViewColor.textColor
		self.padLabel.font = ACFont.defaultBoldFont.font
		self.contentView.addSubview(self.padLabel)
		self.padLabel.snp.makeConstraints { make in
			make.centerY.equalTo(self.padSwither)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.padSwither.snp.leading)
		}
		self.setupPadTextFields()
	}

	func setupSaveSettingsOrRegisterButton() {
		switch self.userSettings?.settingsType {
		case .register:
			self.setupRegisterButton()
		default:
			self.setupSaveSettingsButton()
		}
		self.contentView.addSubview(self.saveSettingsOrRegisterButton)
		self.saveSettingsOrRegisterButton.snp.makeConstraints { make in
			make.top.equalTo(self.newPadCheckingTextField.snp.bottom).offset(AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.bottom.equalTo(self.contentView).offset(-AppContraints.midEdge)
		}
	}
}

@objc
extension GeneralUserInfoView {
	func padSwitcherValueChanged(_ sender: UISwitch) {
		self.changePadTFVisability()
	}
}

private extension GeneralUserInfoView {
	func collectionViewSettings() {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .horizontal
		flowLayout.minimumLineSpacing = 30
		flowLayout.itemSize = CGSize(width: AppContraints.Settings.avatarHeight,
									height: AppContraints.Settings.avatarHeight)
		self.avatarCollectionView.collectionViewLayout = flowLayout
		self.avatarCollectionView.backgroundColor = .clear
		self.avatarCollectionView.delegate = self
		self.avatarCollectionView.dataSource = self
		self.avatarCollectionView.register(AvatarCollectionViewCell.self,
										   forCellWithReuseIdentifier: "AvatarCollectionViewCell")
	}
}

// setupPasswordFields
private extension GeneralUserInfoView {
	func setupPasswordFields() {
		switch self.userSettings?.settingsType {
		case .register:
			self.setupPasswordFieldsForRegister()
		default:
			self.setupPasswordFieldsForExistingUser()
		}
	}
	func setupPasswordFieldsForRegister() {
		self.newPasswordEmailTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																							cornerRadius: AppContraints.Settings.cornerRadiusTF,
																							placeholder: "Password. 6 characters minimum",
																							isSecureTextEntry: true))
		self.contentView.addSubview(self.newPasswordEmailTextField)
		self.newPasswordEmailTextField.snp.makeConstraints { make in
			make.top.equalTo(self.passwordEmailLabel.snp.bottom).offset(AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
		self.newPasswordEmailCheckingTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																									cornerRadius: AppContraints.Settings.cornerRadiusTF,
																									placeholder: "Repeat password",
																									isSecureTextEntry: true))
		self.contentView.addSubview(self.newPasswordEmailCheckingTextField)
		self.newPasswordEmailCheckingTextField.snp.makeConstraints { make in
			make.top.equalTo(self.newPasswordEmailTextField.snp.bottom).offset(AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
	}

	func setupPasswordFieldsForExistingUser() {
		self.oldPasswordEmailTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																							cornerRadius: AppContraints.Settings.cornerRadiusTF,
																							placeholder: "Old passworld",
																							isSecureTextEntry: true))
		self.contentView.addSubview(self.oldPasswordEmailTextField)
		self.oldPasswordEmailTextField.snp.makeConstraints { make in
			make.top.equalTo(self.passwordEmailLabel.snp.bottom).offset(AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
		self.newPasswordEmailTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																							cornerRadius: AppContraints.Settings.cornerRadiusTF,
																							placeholder: "Password. 6 characters minimum",
																							isSecureTextEntry: true))
		self.contentView.addSubview(self.newPasswordEmailTextField)
		self.newPasswordEmailTextField.snp.makeConstraints { make in
			make.top.equalTo(self.oldPasswordEmailTextField.snp.bottom).offset(AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
		self.newPasswordEmailCheckingTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																									cornerRadius: AppContraints.Settings.cornerRadiusTF,
																									placeholder: "Repeat password",
																									isSecureTextEntry: true))
		self.contentView.addSubview(self.newPasswordEmailCheckingTextField)
		self.newPasswordEmailCheckingTextField.snp.makeConstraints { make in
			make.top.equalTo(self.newPasswordEmailTextField.snp.bottom).offset(AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
	}
}

// setupPadTF
private extension GeneralUserInfoView {
	func setupPadTextFields() {
		switch self.userSettings?.settingsType {
		case .register:
			self.setupPadForRegister()
		default:
			self.setupPadForExistingUser()
		}
		self.changePadTFVisability()
	}

	func changePadTFVisability() {
		if self.padSwither.isOn {
			self.oldPadTextField.isHidden = false
			self.newPadTextField.isHidden = false
			self.newPadCheckingTextField.isHidden = false
		} else {
			self.oldPadTextField.isHidden = true
			self.newPadTextField.isHidden = true
			self.newPadCheckingTextField.isHidden = true
		}
	}

	func setupPadForRegister() {
		self.newPadTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																				  cornerRadius: AppContraints.Settings.cornerRadiusTF,
																				  placeholder: "6 numbers",
																				  isSecureTextEntry: true))
		self.newPadTextField.keyboardType = .numberPad
		self.contentView.addSubview(self.newPadTextField)
		self.newPadTextField.snp.makeConstraints { make in
			make.top.equalTo(self.padSwither.snp.bottom).offset(AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
		self.newPadCheckingTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																						  cornerRadius: AppContraints.Settings.cornerRadiusTF,
																						  placeholder: "Repeat password",
																						  isSecureTextEntry: true))
		self.newPadCheckingTextField.keyboardType = .numberPad
		self.contentView.addSubview(self.newPadCheckingTextField)
		self.newPadCheckingTextField.snp.makeConstraints { make in
			make.top.equalTo(self.newPadTextField.snp.bottom).offset(AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
	}

	func setupPadForExistingUser() {
		self.oldPadTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																				  cornerRadius: AppContraints.Settings.cornerRadiusTF,
																				  placeholder: "Old number code",
																				  isSecureTextEntry: true))
		self.oldPadTextField.keyboardType = .numberPad
		self.contentView.addSubview(self.oldPadTextField)
		self.oldPadTextField.snp.makeConstraints { make in
			make.top.equalTo(self.padSwither.snp.bottom).offset(AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
		self.newPadTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																				  cornerRadius: AppContraints.Settings.cornerRadiusTF,
																				  placeholder: "6 numbers",
																				  isSecureTextEntry: true))
		self.newPadTextField.keyboardType = .numberPad
		self.contentView.addSubview(self.newPadTextField)
		self.newPadTextField.snp.makeConstraints { make in
			make.top.equalTo(self.oldPadTextField.snp.bottom).offset(AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
		self.newPadCheckingTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																						  cornerRadius: AppContraints.Settings.cornerRadiusTF,
																						  placeholder: "Repeat password",
																						  isSecureTextEntry: true))
		self.newPadCheckingTextField.keyboardType = .numberPad
		self.contentView.addSubview(self.newPadCheckingTextField)
		self.newPadCheckingTextField.snp.makeConstraints { make in
			make.top.equalTo(self.newPadTextField.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.Settings.edgesTFToSuperview)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
	}
}

// setup SaveSettings or Register Button
private extension GeneralUserInfoView {
	func setupSaveSettingsButton() {
		self.saveSettingsOrRegisterButton = OvalButton(withTitle: "Save settings",
													   width: AppContraints.Settings.widthButton,
													   height: AppContraints.Settings.heightButton,
													   color: self.colors)
	}

	func setupRegisterButton() {
		self.saveSettingsOrRegisterButton = OvalButton(withTitle: "Register",
													   width: AppContraints.Settings.widthButton,
													   height: AppContraints.Settings.heightButton,
													   color: self.colors)
		self.contentView.addSubview(self.saveSettingsOrRegisterButton)
	}
}


struct UserSettingsViewModel {
	var settingsType: SettingsType = .userSettings
	var avatar: String? = "Redd"
	var name: String? = "Ann"

	var email: String? = "bla1@bla.ru"
	var oldEmailPassword: String? = "oldEmailPassword"
	var newEmailPassword: String? = nil

	var padCodeExist: Bool {
		!(self.oldPadCode?.isEmpty ?? false)
	}
	var oldPadCode: String? = "133"
	var newPadCode: String? = "458"

	enum SettingsType {
		case register
		case userSettings
	}
	enum PadCodeType {
		case exist
		case empty
		case notUsed
	}
}

