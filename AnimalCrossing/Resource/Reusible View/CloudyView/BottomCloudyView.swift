// BottomCloudyView.swift
// Created by Anastasiya Kudasheva on 19.03.2022

import UIKit

class BottomCloudyView: UIView {
	private let screenType: ScreenTypes?

	init(screenType: ScreenTypes?) {
		self.screenType = screenType
		super.init(frame: .zero)
		self.loadUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension BottomCloudyView {
	func loadUI() {
		let imageView = UIImageView()
		self.addSubview(imageView)
		imageView.snp.makeConstraints { make in
			make.edges.equalTo(self)
		}
		switch self.screenType {
		case .loggined:
			imageView.image = UIImage(named: AppImage.TopBottomImage.logBottom.rawValue)
		default:
			imageView.image = UIImage(named: AppImage.TopBottomImage.unlogBottom.rawValue)
		}
	}
}
