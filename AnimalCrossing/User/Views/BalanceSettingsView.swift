//
//  BalanceSettingsView.swift
//  Created by Anastasiya Kudasheva on 11.09.2021

import UIKit

class BalanceSettingsView: UIView {
	lazy var colors = ColorSet(for: .other)

	var balanceLabel = UILabel()
	var loanBalanceLabel = UILabel()
	var balanceTextField = UITextField()
	var loanBalanceTextField = UITextField()
	var saveLoanBalanceButton = UIButton()

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
		self.setupSavingBalanceSection()
		self.setupLoanBalanceSection()
		self.setupSaveBalanceButton()
	}

	func setupSavingBalanceSection() {
		self.balanceLabel.text = "Saving Balance"
		self.balanceLabel.numberOfLines = 0
		self.balanceLabel.textColor = self.colors.mainViewColor.textColor
		self.balanceLabel.font = ACFont.defaultBoldFont.font
		self.addSubview(self.balanceLabel)
		self.balanceLabel.snp.makeConstraints { make in
			make.top.equalTo(self).offset(AppContraints.standartEdge)
			make.leading.equalTo(self).offset(AppContraints.Settings.edgesTFToSuperview)
			make.width.equalTo(AppContraints.Settings.widthAccountLabel)
		}
		self.balanceTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																						cornerRadius: AppContraints.standartCornerRadius,
																						text: ""))
		self.addSubview(self.balanceTextField)
		self.balanceTextField.snp.makeConstraints { make in
			make.top.equalTo(self.balanceLabel)
			make.leading.equalTo(self.balanceLabel.snp.trailing).offset(AppContraints.midEdge)
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
			make.top.equalTo(self.balanceLabel.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self).offset(AppContraints.Settings.edgesTFToSuperview)
			make.width.equalTo(AppContraints.Settings.widthAccountLabel)
		}
		self.loanBalanceTextField = CustomTextField(settings: CustomTextField.Settings(color: self.colors,
																					   cornerRadius: AppContraints.standartCornerRadius,
																					   text: ""))
		self.addSubview(self.loanBalanceTextField)
		self.loanBalanceTextField.snp.makeConstraints { make in
			make.top.equalTo(self.balanceTextField.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.loanBalanceLabel.snp.trailing).offset(AppContraints.midEdge)
			make.trailing.equalTo(self).offset(-AppContraints.Settings.edgesTFToSuperview)
			make.height.equalTo(AppContraints.Settings.heightTF)
		}
	}

	func setupSaveBalanceButton() {
		self.saveLoanBalanceButton = OvalButton(withTitle: "Save Balance",
												width: AppContraints.Settings.widthButton,
												height: AppContraints.Settings.heightButton,
												color: self.colors)
		self.addSubview(saveLoanBalanceButton)
		self.saveLoanBalanceButton.snp.makeConstraints { make in
			make.top.equalTo(self.loanBalanceLabel.snp.bottom).offset(AppContraints.midEdge)
			make.centerX.equalTo(self)
		}
	}
}
