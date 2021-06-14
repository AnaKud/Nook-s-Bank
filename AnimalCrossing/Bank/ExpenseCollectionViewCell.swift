//
//  ExpenseCollectionViewCell.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 13.06.2021.
//

import UIKit

class ExpenseCollectionViewCell: UICollectionViewCell {
   // var expense: ExpenseViewModel?
    
    let expenseTypeImageView = UIImageView()
    //var circleView = UIView()
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
            make.top.leading.trailing.equalTo(contentView)
            make.width.height.equalTo(AppContraints.Bank.collectionCellWidth)
        }
//        expenseTypeImageView.addSubview(circleView)
//        circleView.snp.makeConstraints { make in
//            make.top.leading.equalTo(expenseTypeImageView).offset(AppContraints.News.cellBgEdge)
//            make.width.height.equalTo(AppContraints.Bank.circleWidth)
//        }
//        print(circleWidth)
        //circleView.layer.masksToBounds = true
        contentView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(expenseTypeImageView.snp.bottom).offset(-AppContraints.midEdge)
            make.leading.equalTo(contentView).offset(AppContraints.minEdge)
            make.trailing.equalTo(contentView).offset(-AppContraints.minEdge)
        }
        valueLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 14)
        valueLabel.textAlignment = .center
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(valueLabel.snp.bottom).offset(-AppContraints.midEdge)
            make.leading.equalTo(contentView).offset(AppContraints.minEdge)
            make.trailing.bottom.equalTo(contentView).offset(-AppContraints.minEdge)
        }
        
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 0
        dateLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        dateLabel.font = UIFont(name: AppFont.maruLight.rawValue, size: 10)
    }
    
    func config(item: ExpenseViewModel) {
        switch item.operationType {
        case .plus:
            valueLabel.text = "+\(item.value)"
            valueLabel.textColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        case .minus:
            valueLabel.text = "-\(item.value)"
            valueLabel.textColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        }
        
       // circleView = CustomViewController.makeCircleView(circleViewSize: AppContraints.Bank.circleWidth, firstCharacter: item.operationType.rawValue)
        //valueLabel.text = "\(item.value)"
        dateLabel.text = item.dateString
        expenseTypeImageView.image = UIImage(named: item.imageName)
        print("1")
        
    }
    
    
}
