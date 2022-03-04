// NewsTableViewCell.swift
// Created by Anastasiya Kudasheva on 11.06.2021.

import UIKit

class NewsTableViewCell: UITableViewCell {
	private var colors: ColorSet?

	private let backView = UIView()
	private let dateView = UIView()
	private let eventLabel = UILabel()
	private var eventCircleView = UIView()
	private let dateLabel = UILabel()

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(false, animated: animated)
	}

	func setupColors(_ colors: ColorSet?) {
		self.colors = colors
		self.contentView.backgroundColor = .clear
		self.backView.backgroundColor = colors?.cellColorSet.backgroundViewColor
		self.dateView.backgroundColor = colors?.cellColorSet.topViewColor
		self.dateLabel.textColor = colors?.cellColorSet.titleTextColor
		self.eventLabel.textColor = colors?.cellColorSet.itemTextColor
	}

	func config(withEvent event: NewsViewModel) {
		self.dateLabel.text = event.date
		self.eventLabel.text = event.event
		let firstCharacter: String = "\(event.type.abbreviation)"
		self.eventCircleView = CircleView(size: AppContraints.CellSizes.circleViewSize,
										  firstCharacter: firstCharacter,
										  colorSet: self.colors)
		self.setupLayout()
	}

	private func setupLayout() {
		self.contentView.addSubview(self.backView)
		self.backView.snp.makeConstraints { make in
			make.top.leading.equalTo(self.contentView).offset(AppContraints.CellSizes.cellBgEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.CellSizes.cellBgEdge)
			make.bottom.equalTo(self.contentView)
		}

		self.backView.layer.cornerRadius = AppContraints.CellSizes.cellCornerRadius
		self.backView.layer.masksToBounds = true
		self.backView.addSubview(self.dateView)
		self.dateView.snp.makeConstraints { make in
			make.top.leading.trailing.equalTo(self.backView)
			make.height.equalTo(AppContraints.CellSizes.topViewHeight)
		}
		self.dateView.addSubview(self.eventCircleView)
		self.eventCircleView.snp.makeConstraints { make in
			make.leading.equalTo(self.dateView).offset(AppContraints.CellSizes.cellBgEdge)
			make.centerY.equalTo(self.dateView)
			make.height.width.equalTo(AppContraints.CellSizes.circleViewSize)
		}

		self.dateView.addSubview(self.dateLabel)
		self.dateLabel.snp.makeConstraints { make in
			make.leading.equalTo(self.eventCircleView.snp.trailing).offset(AppContraints.CellSizes.cellBgEdge)
			make.trailing.equalTo(self.dateView).offset(-AppContraints.CellSizes.cellBgEdge)
			make.top.equalTo(self.dateView).offset(AppContraints.CellSizes.cellBgEdge)
			make.bottom.equalTo(self.dateView).offset(-AppContraints.CellSizes.cellBgEdge)
		}
		self.dateLabel.font = ACFont.newsBoldFont.font
		self.backView.addSubview(self.eventLabel)
		self.eventLabel.snp.makeConstraints { make in
			make.top.equalTo(self.dateView.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
			make.leading.equalTo(self.backView).offset(AppContraints.CellSizes.cellBgEdge)
			make.trailing.bottom.equalTo(self.backView).offset(-AppContraints.CellSizes.cellBgEdge)
			make.height.greaterThanOrEqualTo(40)
		}
		self.eventLabel.numberOfLines = 0
		self.eventLabel.font = ACFont.newsLightFont.font
	}
}
