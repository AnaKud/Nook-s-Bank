// ExpenseCollectionViewCell.swift
// Created by Anastasiya Kudasheva on 13.06.2021.

import UIKit

class ExpenseCollectionViewCell: UICollectionViewCell {
	private let expenseTypeImageView = UIImageView()
	private let valueLabel = UILabel()
	private let dateLabel = UILabel()

	private let circleWidth = AppContraints.Bank.collectionCellWidth / 2

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.contentView.backgroundColor = .clear
		self.setUpLayout()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setUpLayout() {
		self.contentView.addSubview(self.expenseTypeImageView)
		self.expenseTypeImageView.snp.makeConstraints { make in
			make.top.equalTo(self.contentView)
			make.leading.equalTo(self.contentView).offset(AppContraints.Bank.imageCollectionViewEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.Bank.imageCollectionViewEdge)
			make.width.height.equalTo(AppContraints.Bank.imageCollectionViewSize)
		}
		self.contentView.addSubview(self.valueLabel)
		self.valueLabel.snp.makeConstraints { make in
			make.top.equalTo(self.expenseTypeImageView.snp.bottom).offset(-AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.minEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.minEdge)
		}
		self.valueLabel.font = ACFont.bankValueFont.font
		self.valueLabel.textAlignment = .center
		self.contentView.addSubview(dateLabel)
		self.dateLabel.snp.makeConstraints { make in
			make.top.equalTo(self.valueLabel.snp.bottom).offset(-AppContraints.minEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.minEdge)
			make.trailing.bottom.equalTo(self.contentView).offset(-AppContraints.minEdge)
		}
		self.dateLabel.textAlignment = .center
		self.dateLabel.numberOfLines = 0
		self.dateLabel.font = ACFont.bankDateFont.font
	}

	func config(item: ExpenseViewModel, textColor: UIColor?) {
		self.dateLabel.text = item.date
		self.valueLabel.text = item.expenseText
		self.valueLabel.textColor = item.expenseColor
		self.expenseTypeImageView.image = item.expenseType.image
		self.dateLabel.textColor = textColor
	}
}
