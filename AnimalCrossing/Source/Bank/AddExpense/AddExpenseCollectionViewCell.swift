// AddExpenseCollectionViewCell.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

final class AddExpenseCollectionViewCell: UICollectionViewCell {
	private var bankViewColor: ColorSet.BankViewColor?

	private let highlitedCircle = UIView()
	private let imageView = UIImageView()
	private let label = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.contentView.backgroundColor = .clear
		self.loadUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override var isSelected: Bool {
		didSet {
			if self.isSelected == true {
				self.highlitedCircle.backgroundColor = self.bankViewColor?.backgroundViewColor
			} else {
				self.highlitedCircle.backgroundColor = .clear
			}
		}
	}

	func config(_ item: ExpenseType, bankViewColor: ColorSet.BankViewColor) {
		self.imageView.image = item.image
		self.label.text = item.name
		self.label.textColor = bankViewColor.itemTextColor
		self.bankViewColor = bankViewColor
	}
}

private extension AddExpenseCollectionViewCell {
	func loadUI() {
		self.contentView.addSubview(self.highlitedCircle)
		self.highlitedCircle.snp.makeConstraints { make in
			make.top.equalTo(self.contentView)
			make.leading.equalTo(self.contentView).offset(AppContraints.AddExpense.imageCollectionViewEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.AddExpense.imageCollectionViewEdge)
			make.width.height.equalTo(AppContraints.AddExpense.imageCollectionViewSize)
			make.centerX.equalTo(self.contentView)
		}
		self.highlitedCircle.addSubview(self.imageView)
		self.imageView.snp.makeConstraints { make in
			make.top.bottom.equalTo(self.highlitedCircle)
			make.leading.equalTo(self.highlitedCircle)
			make.trailing.equalTo(self.highlitedCircle)
			make.centerX.equalTo(self.highlitedCircle)
		}
		self.contentView.addSubview(self.label)
		self.label.snp.makeConstraints { make in
			make.top.lessThanOrEqualTo(self.highlitedCircle.snp.bottom).offset(10)
			make.leading.trailing.equalTo(self.contentView)
			make.bottom.lessThanOrEqualTo(self.contentView).offset(10)
		}
		self.label.textAlignment = .center
		self.label.numberOfLines = 1
		self.label.adjustsFontSizeToFitWidth = true
		self.label.font = ACFont.bankValueFont.font

		self.highlitedCircle.backgroundColor = .clear
		self.highlitedCircle.layer.cornerRadius = self.contentView.bounds.width / 2

		self.layoutIfNeeded()
	}
}
