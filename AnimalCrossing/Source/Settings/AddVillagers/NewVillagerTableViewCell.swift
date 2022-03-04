// NewVillagerTableViewCell.swift
// Created by Anastasiya Kudasheva on 15.10.2021

import UIKit

class NewVillagerTableViewCell: UITableViewCell {
	private let nameLabel = UILabel()
	private let speciesLabel = UILabel()
	private let birthdayLabel = UILabel()

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		self.setUpLayout()
	}

	func config(with item: VillagerViewModel) {
		self.backgroundColor = item.color.color
		self.nameLabel.text = item.name
		self.speciesLabel.text = item.species
		self.birthdayLabel.text = item.birthday
	}

	private func setUpLayout() {
		self.selectedBackgroundView?.backgroundColor = ColorSet.CellColor(for: .other).topViewColor
		self.addSubview(self.nameLabel)
		self.nameLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(AppContraints.midEdge)
			make.leading.equalToSuperview().offset(AppContraints.doubleEdge)
			make.bottom.equalToSuperview().offset(-AppContraints.midEdge)
		}
		self.nameLabel.font = ACFont.newsLightFont.font
		self.addSubview(self.birthdayLabel)
		self.birthdayLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(AppContraints.midEdge)
			make.trailing.equalToSuperview().offset(-AppContraints.doubleEdge)
			make.bottom.equalToSuperview().offset(-AppContraints.midEdge)
		}
		self.birthdayLabel.font = ACFont.newsLightFont.font
		self.addSubview(self.speciesLabel)
		self.speciesLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(AppContraints.midEdge)
			make.centerX.equalToSuperview()
			make.bottom.equalToSuperview().offset(-AppContraints.midEdge)
		}
		self.speciesLabel.font = ACFont.newsLightFont.font
		self.speciesLabel.textAlignment = .center
	}
}
