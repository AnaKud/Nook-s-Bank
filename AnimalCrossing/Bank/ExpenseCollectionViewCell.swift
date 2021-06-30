//
//  ExpenseCollectionViewCell.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 13.06.2021.
//

import UIKit

class ExpenseCollectionViewCell: UICollectionViewCell {
    var colors: ColorsSet?
    var customView: CustomView?
    
    let expenseTypeImageView = UIImageView()
    let valueLabel = UILabel()
    let dateLabel = UILabel()
    
    private let circleWidth = AppContraints.Bank.collectionCellWidth / 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        self.setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        contentView.addSubview(expenseTypeImageView)
        expenseTypeImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).offset(AppContraints.Bank.imageCollectionViewEdge)
            make.trailing.equalTo(contentView).offset(-AppContraints.Bank.imageCollectionViewEdge)
            make.width.height.equalTo(AppContraints.Bank.imageCollectionViewSize)
        }
        contentView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(expenseTypeImageView.snp.bottom).offset(-AppContraints.minEdge)
            make.leading.equalTo(contentView).offset(AppContraints.minEdge)
            make.trailing.equalTo(contentView).offset(-AppContraints.minEdge)
        }
        valueLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 14)
        valueLabel.textAlignment = .center
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(valueLabel.snp.bottom).offset(-AppContraints.minEdge)
            make.leading.equalTo(contentView).offset(AppContraints.minEdge)
            make.trailing.bottom.equalTo(contentView).offset(-AppContraints.minEdge)
        }
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 0
        dateLabel.textColor = colors?.bankViewColor.itemTextColor
        dateLabel.font = UIFont(name: AppFont.maruLight.rawValue, size: 10)
    }
    
    func config(item: ExpenseViewModel) {
        switch item.operationType {
        case .plus:
            valueLabel.text = "+\(item.value)"
            valueLabel.textColor = colors?.bankViewColor.incomeLabelColor
        case .minus:
            valueLabel.text = "-\(item.value)"
            valueLabel.textColor = colors?.bankViewColor.expenseLabelColor
        }
        dateLabel.text = item.dateString
        expenseTypeImageView.image = UIImage(named: item.imageName)
    }
}
