// VillagerTableViewCell.swift
// Created by Anastasiya Kudasheva on 22.09.2021

import UIKit

class VillagerTableViewCell: UITableViewCell {
	let nameLabel = UILabel()

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		self.setUpLayout()
	}

	func config(with villager: VillagerViewModel) {
		self.nameLabel.text = villager.name
	}

	private func setUpLayout() {
		self.backgroundColor = .clear
		self.addSubview(self.nameLabel)
		self.nameLabel.snp.makeConstraints { make in
			make.edges.equalTo(self)
		}
	}
}
