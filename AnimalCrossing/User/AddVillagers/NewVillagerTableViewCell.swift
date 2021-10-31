//
//  NewVillagerTableViewCell.swift
//  Created by Anastasiya Kudasheva on 15.10.2021

import UIKit

class NewVillagerTableViewCell: UITableViewCell {
	let nameLabel = UILabel()

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		self.setUpLayout()
	}

	func config(with name: String) {
		self.nameLabel.text = name
	}

	private func setUpLayout() {
		self.addSubview(self.nameLabel)
		self.nameLabel.snp.makeConstraints { make in
			make.edges.equalTo(self)
		}
	}
}
