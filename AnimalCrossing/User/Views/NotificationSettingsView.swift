//
//  NotificationSettingsView.swift
//  Created by Anastasiya Kudasheva on 18.09.2021

import UIKit

class NotificationSettingsView: UIView {
	lazy var colors = ColorSet(for: .other)

	var scrollView = UIScrollView()
	var contentView = UIView()
	
	var notificationModeLabel = UILabel()

	init() {
		super.init(frame: .zero)
		self.loadUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func loadUI() {
		self.setupScrollView()
		self.setupNotificationMode()
	}
}

private extension NotificationSettingsView {
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
		self.scrollView.contentSize = CGSize(width: self.frame.width,
											 height: self.frame.height)
	}

	func setupNotificationMode() {
		self.notificationModeLabel.text = "Select notification mode"
		self.notificationModeLabel.numberOfLines = 0
		self.notificationModeLabel.textAlignment = .center
		self.notificationModeLabel.textColor = self.colors.mainViewColor.textColor
		self.notificationModeLabel.font = ACFont.defaultBoldFont.font
		self.contentView.addSubview(self.notificationModeLabel)
		self.notificationModeLabel.snp.makeConstraints { make in
			make.top.equalTo(self.contentView).offset(AppContraints.midEdge)
		}
	}
}

extension NotificationSettingsView: UIScrollViewDelegate { }
