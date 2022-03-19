// CustomViewController.swift
// Created by Anastasiya Kudasheva on 06.06.2021.

import SnapKit
import UIKit

class CloudViewController: UIViewController {
	var colors: ColorSet { ColorSet(for: self.screenType) }
	private(set) var customView: CustomView?
	private(set) var screenType: ScreenTypes?
	private(set) var controllerTitle: String?

	private lazy var topImageView = TopCloudyView(screenType: self.screenType)
	private lazy var bottomImageView = BottomCloudyView(screenType: self.screenType)
	private let titleLabel = UILabel()

	private(set) var contentView = UIView()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.customView = CustomView(colorSet: colors)
		self.loadUI()
	}

	func showErrorAlert(withMessage message: FailureCases) {
		let alert = CustomAlertController(title: "Error", message: message.rawValue, preferredStyle: .alert)
		alert.changeAlertColors(for: self.screenType)
		let saveAction = UIAlertAction(title: "Ok", style: .default)
		alert.addAction(saveAction)
		self.present(alert, animated: true)
	}

	func showAlert(title: String?, message: String, completion: (() -> Void)?) {
		let alert = CustomAlertController(title: title,
										  message: message,
										  preferredStyle: .alert)
		alert.changeAlertColors(for: self.screenType)
		let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { _ in completion?() }
		alert.addAction(cancelAction)
		self.present(alert, animated: true)
	}

	func showTopAndContentView() {
		self.setupTopLayout()
		self.setupContentViewLayout()
	}

	func setupScreenType(_ screenType: ScreenTypes) {
		self.screenType = screenType
	}

	func setupControllerTitle(_ controllerTitle: String?) {
		self.controllerTitle = controllerTitle
	}
}

extension CloudViewController: INavigator {
	var currentVC: UIViewController? { return self }
}

private extension CloudViewController {
	func loadUI() {
		let tap = UITapGestureRecognizer(target: self,
										 action: #selector(self.dissmissKeyboard))
		tap.cancelsTouchesInView = false
		self.view.addGestureRecognizer(tap)

		self.screenTypeSettings()
		self.setupTopLayout()
		self.setupBottomLayout()
		self.setupContentViewLayout()
	}

	func setupTopLayout() {
		self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.topItem?.title = ""
		self.navigationController?.navigationBar.barStyle = .default
		self.navigationController?.navigationBar.tintColor = self.colors.mainViewColor.navigationItemColor

		self.view.addSubview(self.topImageView)
		self.topImageView.snp.makeConstraints { make in
			make.top.trailing.leading.equalTo(self.view)
			make.height.equalTo(AppContraints.navAndTabHeight)
		}
	}

	func setupContentViewLayout() {
		self.view.addSubview(self.contentView)
		self.contentView.snp.makeConstraints { make in
			make.trailing.leading.equalTo(self.view)
			make.top.equalTo(self.topImageView.snp.bottom).offset(AppContraints.minEdge)
			make.bottom.equalTo(self.bottomImageView.snp.top).offset(-AppContraints.minEdge)
		}
		self.contentView.backgroundColor = .clear
		if self.screenType != .loginScreen {
			self.view.addSubview(self.titleLabel)
			self.titleLabel.snp.makeConstraints { make in
				make.top.equalTo(self.view).offset(AppContraints.navTitle)
				make.leading.trailing.equalTo(self.view)
			}
			self.titleLabel.text = self.controllerTitle
			self.titleLabel.textAlignment = .center
			self.titleLabel.font = ACFont.controllerTitleFont.font
		}
		self.titleLabel.numberOfLines = 0
	}

	func setupBottomLayout() {
		self.tabBarController?.tabBar.barTintColor = UIColor.clear
		self.tabBarController?.tabBar.backgroundImage = UIImage()
		self.tabBarController?.tabBar.shadowImage = UIImage()

		self.view.addSubview(self.bottomImageView)
		self.bottomImageView.snp.makeConstraints { make in
			make.bottom.trailing.leading.equalTo(self.view)
			make.height.equalTo(AppContraints.navAndTabHeight)
		}
	}

	func screenTypeSettings() {
		self.view.backgroundColor = self.colors.mainViewColor.backgroundColor
		self.titleLabel.textColor = self.colors.mainViewColor.textColor
	}
}

@objc extension CloudViewController {
	func dissmissKeyboard() {
		self.view.endEditing(true)
	}
}
