// BalanceSettingsView.swift
// Created by Anastasiya Kudasheva on 11.09.2021

import UIKit

class BalanceSettingsView: UIView {
	private lazy var colors = ColorSet(for: .other)

	private var bellsBalanceLabel = UILabel()
	private var bellsBalanceTextField = UITextField()
	private var loanBalanceLabel = UILabel()
	private var loanBalanceTextField = UITextField()
	private var milesBalanceLabel = UILabel()
	private var milesBalanceTextField = UITextField()
	private var pokiBalanceLabel = UILabel()
	private var pokiBalanceTextField = UITextField()
	
	private var saveLoanBalanceButton = UIButton()

	override init(frame: CGRect) {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		self.loadUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension BalanceSettingsView {
	func loadUI() {
		self.setupBellsBalanceSection()
		self.setupLoanBalanceSection()
		self.setupMilesBalanceSection()
		self.setupPokiBalanceSection()
		self.setupSaveBalanceButton()
	}

	func setupBellsBalanceSection() {
		self.bellsBalanceLabel.text = "Bells Balance"
		self.bellsBalanceLabel.numberOfLines = 0
		self.bellsBalanceLabel.textColor = self.colors.mainViewColor.textColor
		self.bellsBalanceLabel.font = ACFont.defaultBoldFont.font
		self.addSubview(self.bellsBalanceLabel)
		self.bellsBalanceLabel.snp.makeConstraints { make in
			make.top.equalTo(self).offset(AppContraints.standartEdge)
			make.leading.equalTo(self).offset(AppContraints.Settings.edgesTFToSuperview)
			make.width.equalTo(AppContraints.Settings.widthAccountLabel)
		}
		self.bellsBalanceTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																				   cornerRadius: AppContraints.standartCornerRadius,
																				   text: ""))
		self.addSubview(self.bellsBalanceTextField)
		self.bellsBalanceTextField.snp.makeConstraints { make in
			make.top.equalTo(self.bellsBalanceLabel)
			make.leading.equalTo(self.bellsBalanceLabel.snp.trailing).offset(AppContraints.midEdge)
			make.trailing.equalTo(self).offset(-AppContraints.Settings.edgesTFToSuperview)

			make.height.equalTo(AppContraints.Settings.heightTF)
		}
	}

	func setupLoanBalanceSection() {
		self.loanBalanceLabel.text = "Loan Balance"
		self.loanBalanceLabel.numberOfLines = 0
		self.loanBalanceLabel.textColor = self.colors.mainViewColor.textColor
		self.loanBalanceLabel.font = ACFont.defaultBoldFont.font
		self.addSubview(self.loanBalanceLabel)
		self.loanBalanceLabel.snp.makeConstraints { make in
			make.top.equalTo(self.bellsBalanceLabel.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self).offset(AppContraints.Settings.edgesTFToSuperview)
			make.width.equalTo(AppContraints.Settings.widthAccountLabel)
		}
		self.loanBalanceTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																					   cornerRadius: AppContraints.standartCornerRadius,
																					   text: ""))
		self.addSubview(self.loanBalanceTextField)
		self.loanBalanceTextField.snp.makeConstraints { make in
			make.top.equalTo(self.bellsBalanceTextField.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.loanBalanceLabel.snp.trailing).offset(AppContraints.midEdge)
			make.trailing.equalTo(self).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
	}

	func setupMilesBalanceSection() {
		self.milesBalanceLabel.text = "Miles Balance"
		self.milesBalanceLabel.numberOfLines = 0
		self.milesBalanceLabel.textColor = self.colors.mainViewColor.textColor
		self.milesBalanceLabel.font = ACFont.defaultBoldFont.font
		self.addSubview(self.milesBalanceLabel)
		self.milesBalanceLabel.snp.makeConstraints { make in
			make.top.equalTo(self.loanBalanceLabel.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self).offset(AppContraints.Settings.edgesTFToSuperview)
			make.width.equalTo(AppContraints.Settings.widthAccountLabel)
		}
		self.milesBalanceTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																					cornerRadius: AppContraints.standartCornerRadius,
																					text: ""))
		self.addSubview(self.milesBalanceTextField)
		self.milesBalanceTextField.snp.makeConstraints { make in
			make.top.equalTo(self.loanBalanceTextField.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.milesBalanceLabel.snp.trailing).offset(AppContraints.midEdge)
			make.trailing.equalTo(self).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
	}

	func setupPokiBalanceSection() {
		self.pokiBalanceLabel.text = "Poki Balance"
		self.pokiBalanceLabel.numberOfLines = 0
		self.pokiBalanceLabel.textColor = self.colors.mainViewColor.textColor
		self.pokiBalanceLabel.font = ACFont.defaultBoldFont.font
		self.addSubview(self.pokiBalanceLabel)
		self.pokiBalanceLabel.snp.makeConstraints { make in
			make.top.equalTo(self.milesBalanceLabel.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self).offset(AppContraints.Settings.edgesTFToSuperview)
			make.width.equalTo(AppContraints.Settings.widthAccountLabel)
		}
		self.pokiBalanceTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																					cornerRadius: AppContraints.standartCornerRadius,
																					text: ""))
		self.addSubview(self.pokiBalanceTextField)
		self.pokiBalanceTextField.snp.makeConstraints { make in
			make.top.equalTo(self.milesBalanceTextField.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.pokiBalanceLabel.snp.trailing).offset(AppContraints.midEdge)
			make.trailing.equalTo(self).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
	}

	func setupSaveBalanceButton() {
		self.saveLoanBalanceButton = OvalButton(withTitle: "Save Balance",
												width: AppContraints.Settings.widthButton,
												height: AppContraints.Settings.heightButton,
												color: self.colors)
		self.addSubview(self.saveLoanBalanceButton)
		self.saveLoanBalanceButton.snp.makeConstraints { make in
			make.top.equalTo(self.pokiBalanceLabel.snp.bottom).offset(AppContraints.midEdge)
			make.centerX.equalTo(self)
		}
	}
}
