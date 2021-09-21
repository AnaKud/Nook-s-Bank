//
//  NewsTableViewCell.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 11.06.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    var colors: ColorSet?
    var customView: CustomView?

    let backView = UIView()
    let dateView = UIView()
    let eventLabel = UILabel()
    var eventCircleView = UIView()
    let dateLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        self.setupLayout()
    }

    func config(withEvent event: NewsViewModel) {
        dateLabel.text = event.date
        eventLabel.text = event.event
        let firstCharacter: String = "\(event.type.first ?? "+")"
        eventCircleView = CircleView(size: AppContraints.CellSizes.circleViewSize,
									 firstCharacter: firstCharacter,
									 colorSet: self.colors)
    }

    private func setupLayout() {
        contentView.backgroundColor = .clear
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(contentView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.bottom.equalTo(contentView)
        }
        backView.backgroundColor = colors?.cellColorSet.backgroundViewColor
        backView.layer.cornerRadius = AppContraints.CellSizes.cellCornerRadius
        backView.layer.masksToBounds = true
        backView.addSubview(dateView)
        dateView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(backView)
            make.height.equalTo(AppContraints.CellSizes.topViewHeight)
        }
        dateView.backgroundColor = colors?.cellColorSet.topViewColor
        dateView.addSubview(eventCircleView)
        eventCircleView.snp.makeConstraints { make in
            make.leading.equalTo(dateView).offset(AppContraints.CellSizes.cellBgEdge)
            make.centerY.equalTo(dateView)
            make.height.width.equalTo(AppContraints.CellSizes.circleViewSize)
        }
        dateView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(eventCircleView.snp.trailing).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(dateView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.top.equalTo(dateView).offset(AppContraints.CellSizes.cellBgEdge)
            make.bottom.equalTo(dateView).offset(-AppContraints.CellSizes.cellBgEdge)
        }
        dateLabel.font = ACFont.newsBoldFont.font 
        dateLabel.textColor = colors?.cellColorSet.titleTextColor
        backView.addSubview(eventLabel)
        eventLabel.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(backView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.bottom.equalTo(backView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.height.greaterThanOrEqualTo(40)
        }
        eventLabel.numberOfLines = 0
		eventLabel.font = ACFont.newsLightFont.font
        eventLabel.textColor = colors?.cellColorSet.itemTextColor
    }
}
