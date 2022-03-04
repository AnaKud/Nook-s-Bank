// SheetViewController.swift
// Created by Anastasiya Kudasheva on 07.09.2021

import UIKit

protocol ICloseButtonCallBack {
	func closeButtonAction()
}

class SheetViewController: UIViewController {
	private(set) lazy var colors: ColorSet = {
		ColorSet(for: self.screenType)
	}()
	var screenType: ScreenTypes?
	private var closeButtonCallBack: ICloseButtonCallBack?
	let titleLabel = UILabel()
	var contentView = UIView()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.loadUI()
	}

	func loadUI() {
		self.screenTypeSettings()
		self.setupTopLayout()
		self.setupContentView()
	}

	func configureKeyboardDismissing() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
		tap.cancelsTouchesInView = false
		self.view.addGestureRecognizer(tap)
	}

	func setupCallBack(_ callBack: ICloseButtonCallBack) {
		self.closeButtonCallBack = callBack
	}

	func setupHeader(_ text: String) {
		self.titleLabel.text = text
	}
}

private extension SheetViewController {
	func screenTypeSettings() {
		self.view.backgroundColor =
		self.colors.mainViewColor.backgroundColor
		self.titleLabel.textColor = self.colors.mainViewColor.textColor
	}

	func setupTopLayout() {
		self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.topItem?.title = ""
		self.navigationController?.navigationBar.barStyle = .default
		self.navigationController?.navigationBar.tintColor = self.colors.mainViewColor.navigationItemColor
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
																target: self, action: #selector(self.closeButtonTapped))
		self.setupTitleLabel()
	}

	func setupTitleLabel() {
		self.view.addSubview(self.titleLabel)
		self.titleLabel.snp.makeConstraints { make in
			make.top.equalTo(self.view).offset(AppContraints.navTitle)
			make.trailing.leading.equalTo(self.view)
			make.height.equalTo(AppContraints.navAndTabHeight)
		}
		self.titleLabel.textAlignment = .center
		self.titleLabel.font = ACFont.controllerTitleFont.font
		self.titleLabel.numberOfLines = 0
	}

	func setupContentView() {
		self.view.addSubview(self.contentView)
		self.contentView.snp.makeConstraints { make in
			make.top.equalTo(self.titleLabel.snp.bottom)
			make.leading.trailing.bottom.equalTo(self.view)
		}
	}
}

@objc extension SheetViewController {
	func closeButtonTapped() {
		self.closeButtonCallBack?.closeButtonAction()
	}

	func dissmissKeyboard() {
		self.view.endEditing(true)
	}
}
