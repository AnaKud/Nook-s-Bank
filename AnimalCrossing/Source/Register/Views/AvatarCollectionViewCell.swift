// AvatarCollectionViewCell.swift
// Created by Anastasiya Kudasheva on 11.09.2021

import UIKit

class AvatarCollectionViewCell: UICollectionViewCell {
	private var imageView = UIImageView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setUpLayout()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func config(with imageName: String) {
		let image = UIImage(named: imageName)
		self.imageView.image = image
		self.imageView.contentMode = .scaleAspectFill
	}

	private func setUpLayout() {
		self.contentView.backgroundColor = .clear
		self.contentView.addSubview(self.imageView)
		self.imageView.snp.makeConstraints { make in
			make.edges.equalTo(self.contentView)
		}
		self.imageView.layer.cornerRadius = AppContraints.standartCornerRadius
		self.imageView.backgroundColor = #colorLiteral(red: 0.7349590659, green: 0.8215679526, blue: 0.5087055564, alpha: 1)
		self.imageView.layer.masksToBounds = true
	}
}
