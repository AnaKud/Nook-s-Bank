// TopCloudyView.swift
// Created by Anastasiya Kudasheva on 19.03.2022

import UIKit

class TopCloudyView: UIView {
	private let screenType: ScreenType?

	init(screenType: ScreenType?) {
		self.screenType = screenType
		super.init(frame: .zero)
		self.loadUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension TopCloudyView {
	func loadUI() {
		let imageView = UIImageView()
		self.addSubview(imageView)
		imageView.snp.makeConstraints { make in
			make.edges.equalTo(self)
		}
		switch self.screenType {
		case .unlogined, .additionalScreen, .none:
			imageView.image = UIImage(named: AppImage.TopBottomImage.unlogTop.rawValue)
		case .logined:
			imageView.image = UIImage(named: AppImage.TopBottomImage.logTop.rawValue)
		}
	}
}
