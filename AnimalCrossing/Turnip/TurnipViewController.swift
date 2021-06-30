//
//  TurnipViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 27.06.2021.
//

import UIKit

class TurnipViewController: CustomViewController {
    var presenter: ITurnipPresenter
    
    var contentScrollView = UIScrollView()
    //var backgroundView = UIView()
    // Views for buy area
    var buyBackgroundView = UIView()
    var buyTopView = UIView()
    var buyCircleView = UIView()
    var buyTitleLabel = UILabel()
    var buyPriceLabel = UILabel()
    var buyPriceTextField = UITextField()
    var buyCountLabel = UILabel()
    var buyCountTextField = UITextField()
    
    //  Views for turnip calculation area
    var turnipBackgroundView = UIView()
    var turnipTopView = UIView()
    var turnipCircleView = UIView()
    var turnipTitleLabel = UILabel()
    var firstTurnipColumn = UIView()
    var secondTurnipColumn = UIView()
    var thirdTurnipColumn = UIView()
    var morningView = UIView()
    var eveningView = UIView()
    var morningImageView = UIImageView()
    var eveningImageView = UIImageView()
    var monLabel = UILabel()
    
    init(presenter: ITurnipPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let array = self.presenter.dates
        print(array)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupScrollView()
        self.setupBuyArea()
        self.setupTurnipArea()
    }
    
    private func setupScrollView() {
        contentView.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(contentView)
        }
        contentScrollView.delegate = self
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.contentSize = CGSize(width: contentView.frame.width, height: contentView.frame.height)
    }

    private func setupBuyArea() {
        contentScrollView.addSubview(buyBackgroundView)
        buyBackgroundView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentScrollView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(contentScrollView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.width.equalTo(contentScrollView).offset(AppContraints.CellSizes.widthOffset)
        }
        buyBackgroundView.backgroundColor = colors?.cellColorSet.backgroundViewColor
        buyBackgroundView.layer.cornerRadius = AppContraints.CellSizes.cellCornerRadius
        buyBackgroundView.layer.masksToBounds = true
            
        buyBackgroundView.addSubview(buyTopView)
        buyTopView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(buyBackgroundView)
            make.height.equalTo(AppContraints.CellSizes.topViewHeight)
        }
        buyTopView.backgroundColor = colors?.cellColorSet.topViewColor
        buyCircleView = self.customView?.makeCircleView(circleViewSize: AppContraints.CellSizes.circleViewSize, firstCharacter: AppTitle.Turnip.buyForOval) ?? UIView()
        buyTopView.addSubview(buyCircleView)
        buyCircleView.snp.makeConstraints { make in
            make.leading.equalTo(buyTopView).offset(AppContraints.CellSizes.cellBgEdge)
            make.centerY.equalTo(buyTopView)
            make.height.width.equalTo(AppContraints.CellSizes.circleViewSize)
        }
        
        buyTopView.addSubview(buyTitleLabel)
        buyTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(buyCircleView.snp.trailing).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(buyTopView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.top.equalTo(buyTopView).offset(AppContraints.CellSizes.cellBgEdge)
            make.bottom.equalTo(buyTopView).offset(-AppContraints.CellSizes.cellBgEdge)
        }
        buyTitleLabel.text = AppTitle.Turnip.buyTitle
        buyTitleLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 20)
        buyTitleLabel.textColor = colors?.cellColorSet.titleTextColor
        
        buyBackgroundView.addSubview(buyPriceLabel)
        buyPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(buyTopView.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(buyBackgroundView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(buyBackgroundView.snp.centerX).offset(-AppContraints.CellSizes.cellBgEdge)
            make.height.equalTo(AppContraints.Turnip.heightTF)
        }
        buyPriceLabel.text = AppTitle.Turnip.price
        buyPriceLabel.textAlignment = .center
        buyPriceLabel.font = UIFont(name: AppFont.maruLight.rawValue, size: 18)
        buyPriceLabel.textColor = colors?.cellColorSet.itemTextColor

        
        buyPriceTextField = self.customView?.makeTextField(withPlacehoder: AppTitle.Turnip.price, height: AppContraints.Turnip.heightTF, withImageName: "b.circle", isSecureTextEntry: false) ?? UITextField()
        buyBackgroundView.addSubview(buyPriceTextField)
        buyPriceTextField.snp.makeConstraints { make in
            make.top.equalTo(buyPriceLabel.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(buyBackgroundView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(buyBackgroundView.snp.centerX).offset(-AppContraints.CellSizes.cellBgEdge)
            make.bottom.equalTo(buyBackgroundView).offset(-AppContraints.CellSizes.cellBgEdge)
        }
        
        buyBackgroundView.addSubview(buyCountLabel)
        buyCountLabel.snp.makeConstraints { make in
            make.top.equalTo(buyTopView.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(buyBackgroundView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(buyBackgroundView.snp.centerX).offset(AppContraints.CellSizes.cellBgEdge)
            make.height.equalTo(AppContraints.Turnip.heightTF)
        }
        buyCountLabel.text = AppTitle.Turnip.count
        buyCountLabel.textAlignment = .center
        buyCountLabel.font = UIFont(name: AppFont.maruLight.rawValue, size: 18)
        buyCountLabel.textColor = colors?.cellColorSet.itemTextColor
        
        buyCountTextField = self.customView?.makeTextField(withPlacehoder: AppTitle.Turnip.count, height: AppContraints.Turnip.heightTF, withImageName: "multiply.circle", isSecureTextEntry: false) ?? UITextField()
        buyBackgroundView.addSubview(buyCountTextField)
        buyCountTextField.snp.makeConstraints { make in
            make.top.equalTo(buyCountLabel.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(buyBackgroundView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(buyBackgroundView.snp.centerX).offset(AppContraints.CellSizes.cellBgEdge)
            make.bottom.equalTo(buyBackgroundView).offset(-AppContraints.CellSizes.cellBgEdge)
        }
    }

    private func setupTurnipArea() {
        contentScrollView.addSubview(turnipBackgroundView)
        turnipBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(buyBackgroundView.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(contentScrollView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(contentScrollView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.width.equalTo(contentScrollView).offset(AppContraints.CellSizes.widthOffset)
            
            
            make.height.equalTo(300)
            
        }
        turnipBackgroundView.backgroundColor = colors?.cellColorSet.backgroundViewColor
        turnipBackgroundView.layer.cornerRadius = AppContraints.CellSizes.cellCornerRadius
        turnipBackgroundView.layer.masksToBounds = true
            
        turnipBackgroundView.addSubview(turnipTopView)
        turnipTopView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(turnipBackgroundView)
            make.height.equalTo(AppContraints.CellSizes.topViewHeight)
        }
        turnipTopView.backgroundColor = colors?.cellColorSet.topViewColor
        turnipCircleView = self.customView?.makeCircleView(circleViewSize: AppContraints.CellSizes.circleViewSize, firstCharacter: AppTitle.Turnip.turnipForOval) ?? UIView()
        turnipTopView.addSubview(turnipCircleView)
        turnipCircleView.snp.makeConstraints { make in
            make.leading.equalTo(turnipTopView).offset(AppContraints.CellSizes.cellBgEdge)
            make.centerY.equalTo(turnipTopView)
            make.height.width.equalTo(AppContraints.CellSizes.circleViewSize)
        }
        
        turnipTopView.addSubview(turnipTitleLabel)
        turnipTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(turnipCircleView.snp.trailing).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(turnipTopView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.top.equalTo(turnipTopView).offset(AppContraints.CellSizes.cellBgEdge)
            make.bottom.equalTo(turnipTopView).offset(-AppContraints.CellSizes.cellBgEdge)
        }
        turnipTitleLabel.text = AppTitle.Turnip.turnipTitle
        turnipTitleLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 20)
        turnipTitleLabel.textColor = colors?.cellColorSet.titleTextColor
    
        turnipBackgroundView.addSubview(firstTurnipColumn)
        firstTurnipColumn.snp.makeConstraints { make in
            make.top.equalTo(turnipTopView.snp.bottom)
            make.leading.equalTo(turnipBackgroundView)
            make.bottom.equalTo(turnipBackgroundView)
            make.width.equalTo(AppContraints.Turnip.columnWidth)
        }
        
        turnipBackgroundView.addSubview(secondTurnipColumn)
        secondTurnipColumn.snp.makeConstraints { make in
            make.top.equalTo(turnipTopView.snp.bottom)
            make.leading.equalTo(firstTurnipColumn.snp.trailing)
            make.bottom.equalTo(turnipBackgroundView)
            make.width.equalTo(AppContraints.Turnip.columnWidth)
        }
        
        turnipBackgroundView.addSubview(thirdTurnipColumn)
        thirdTurnipColumn.snp.makeConstraints { make in
            make.top.equalTo(turnipTopView.snp.bottom)
            make.leading.equalTo(secondTurnipColumn.snp.trailing)
            make.trailing.bottom.equalTo(turnipBackgroundView)
            make.width.equalTo(AppContraints.Turnip.columnWidth)
        }
        
        secondTurnipColumn.addSubview(morningView)
        morningView.snp.makeConstraints { make in
            make.centerX.equalTo(secondTurnipColumn)
            make.top.equalTo(secondTurnipColumn).offset(AppContraints.minEdge)
            make.height.equalTo(AppContraints.Turnip.morningEveningHeigth)
            make.width.equalTo(AppContraints.Turnip.morningEveningWidth)
        }
        morningView.backgroundColor = colors?.cellColorSet.topViewColor
        morningView.layer.cornerRadius = AppContraints.Turnip.cornerRadius
        morningView.layer.masksToBounds = true
        
        morningView.addSubview(morningImageView)
        morningImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(morningView)
            make.height.width.equalTo(AppContraints.Turnip.imageWidthHeight)
        }
        morningImageView.image = UIImage(systemName: AppImage.Turnip.morning.rawValue)
        morningImageView.tintColor = colors?.cellColorSet.titleTextColor
        
        thirdTurnipColumn.addSubview(eveningView)
        eveningView.snp.makeConstraints { make in
            make.centerX.equalTo(thirdTurnipColumn)
            make.top.equalTo(thirdTurnipColumn).offset(AppContraints.minEdge)
            make.height.equalTo(AppContraints.Turnip.morningEveningHeigth)
            make.width.equalTo(AppContraints.Turnip.morningEveningWidth)
        }
        eveningView.backgroundColor = colors?.cellColorSet.topViewColor
        eveningView.layer.cornerRadius = AppContraints.Turnip.cornerRadius
        eveningView.layer.masksToBounds = true
        
        eveningView.addSubview(eveningImageView)
        eveningImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(eveningView)
            make.height.width.equalTo(AppContraints.Turnip.imageWidthHeight)
        }
        eveningImageView.image = UIImage(systemName: AppImage.Turnip.evening.rawValue)
        eveningImageView.tintColor = colors?.cellColorSet.titleTextColor
        
        firstTurnipColumn.addSubview(monLabel)
        
        
        
        
    }

}

extension TurnipViewController: UIScrollViewDelegate {
    
}
