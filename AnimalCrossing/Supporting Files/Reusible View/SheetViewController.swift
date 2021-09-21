//
//  SheetViewController.swift
//  Created by Anastasiya Kudasheva on 07.09.2021

import UIKit

class SheetViewController: UIViewController {
	var colors: ColorSet?
	var screenType: ScreenTypes?
	var controllerTitle: String?

	let titleLabel = UILabel()
	var contentView = UIView()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.colors = ColorSet(for: screenType)
		self.loadUI()
	}

	func loadUI() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
		tap.cancelsTouchesInView = false
		self.view.addGestureRecognizer(tap)

		self.screenTypeSettings()
		self.setupTopLayout()
		self.setupContentView()
	}
}

private extension SheetViewController {
	func screenTypeSettings() {
		self.view.backgroundColor =
			self.colors?.mainViewColor.backgroundColor
		self.titleLabel.textColor = self.colors?.mainViewColor.textColor
	}

	func setupTopLayout() {
		self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.topItem?.title = ""
		self.navigationController?.navigationBar.barStyle = .default
		self.navigationController?.navigationBar.tintColor = self.colors?.mainViewColor.navigationItemColor
		self.setupTitleLabel()
	}

	func setupTitleLabel() {
		self.view.addSubview(self.titleLabel)
	//	self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
//		self.titleLabel.anchor(top: self.view.topAnchor,
//							   leading: self.view.leadingAnchor,
//							   bottom: nil,
//							   trailing: self.view.trailingAnchor,
//							   padding: UIEdgeInsets(top: AppContraints.navTitle,
//													 left: 0,
//													 bottom: 0,
//													 right: 0))
	//	self.titleLabel.updateHeight(AppContraints.navAndTabHeight)
		self.titleLabel.snp.makeConstraints { make in
			make.top.equalTo(self.view).offset(AppContraints.navTitle)
			make.trailing.leading.equalTo(self.view)
			make.height.equalTo(AppContraints.navAndTabHeight)
		}
		self.titleLabel.textAlignment = .center
		self.titleLabel.font = ACFont.controllerTitleFont.font 
		self.titleLabel.numberOfLines = 0
		self.titleLabel.text = self.controllerTitle
	}

	func setupContentView() {
		self.view.addSubview(self.contentView)
	//	self.contentView.translatesAutoresizingMaskIntoConstraints = false
//		self.contentView.anchor(top: self.titleLabel.bottomAnchor,
//									  leading: self.view.leadingAnchor,
//									  bottom: self.view.bottomAnchor,
//									  trailing: self.view.trailingAnchor,
//									  padding: UIEdgeInsets(top: AppContraints.midEdge,
//															left: 0,
//															bottom: 0,
//															right: 0))
		self.contentView.snp.makeConstraints { make in
			make.top.equalTo(self.titleLabel.snp.bottom).offset(AppContraints.midEdge)
			make.leading.trailing.bottom.equalTo(self.view)
		}
	}
}

@objc extension SheetViewController {
	func dissmissKeyboard() {
		self.view.endEditing(true)
	}
}
