//
//  TurnipViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 27.06.2021.
//

import UIKit

protocol ITurnipViewController {
    func showErrorAlert(withMessage message: FailureCases)
}

class TurnipViewController: CloudViewController {
    var presenter: ITurnipPresenter

    var contentScrollView = UIScrollView()
    // Views for buy area
    var buyBackgroundView = UIView()
    var buyTopView = UIView()
    var buyPriceLabel = UILabel()
    var buyPriceTextField = UITextField()
    var buyCountLabel = UILabel()
    var buyCountTextField = UITextField()
    var buyCalculateButton = UIButton()

    //  Views for turnip calculation area
    var turnipBackgroundView = UIView()
    var turnipTopView = UIView()
    var morningView = UIView()
    var eveningView = UIView()
    var morningImageView = UIImageView()
    var eveningImageView = UIImageView()
    var firstTurnipColumn = UIView()
    var secondTurnipColumn = UIView()
    var thirdTurnipColumn = UIView()
    var turnipPriceCalculateButton = UIButton()

    // Views for week prices
    var monView = UIView()
    var monMorTextField = UITextField()
    var monEveTextField = UITextField()
    var tueView = UIView()
    var tueMorTextField = UITextField()
    var tueEveTextField = UITextField()
    var wedView = UIView()
    var wedMorTextField = UITextField()
    var wedEveTextField = UITextField()
    var thuView = UIView()
    var thuMorTextField = UITextField()
    var thuEveTextField = UITextField()
    var friView = UIView()
    var friMorTextField = UITextField()
    var friEveTextField = UITextField()
    var satView = UIView()
    var satMorTextField = UITextField()
    var satEveTextField = UITextField()

    // Views for Sell
    var sellBackgroundView = UIView()
    var sellTopView = UIView()
    var sellPriceLabel = UILabel()
    var sellCountLabel = UILabel()
    var sellPriceTextField = UITextField()
    var sellCountTextField = UITextField()
    var sellCalculateButton = UIButton()

    init(presenter: ITurnipPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

	@available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	// swiftlint:disable:next prohibited_super_call
    override func loadView() {
        super.loadView()
        self.presenter.loadView(with: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupScrollView()
        self.setupBuyArea()
        self.setupTurnipArea()
        self.setupSellArea()
        self.addActionsForButtons()
    }

    private func addActionsForButtons() {
		buyCalculateButton.addTarget(self, action: #selector(buyCalculateButtonTapped), for: .touchUpInside)
		turnipPriceCalculateButton.addTarget(self, action: #selector(turnipPriceCalculateButtonTapped), for: .touchUpInside)
		sellCalculateButton.addTarget(self, action: #selector(sellCalculateButtonTapped), for: .touchUpInside)
    }
}

// MARK: - SetupViews
// ScrollView
extension TurnipViewController: UIScrollViewDelegate {
    private func setupScrollView() {
        contentView.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(contentView)
        }
        contentScrollView.delegate = self
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.contentSize = CGSize(width: contentView.frame.width, height: contentView.frame.height)
    }

// Buy Area View
    func setupBuyArea() {
        contentScrollView.addSubview(buyBackgroundView)
        buyBackgroundView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentScrollView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(contentScrollView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.width.equalTo(contentScrollView).offset(AppContraints.CellSizes.widthOffset)
        }
        buyBackgroundView.backgroundColor = colors?.cellColorSet.backgroundViewColor
        buyBackgroundView.layer.cornerRadius = AppContraints.CellSizes.cellCornerRadius
        buyBackgroundView.layer.masksToBounds = true
        buyTopView = customView?.setupTopView(text: AppTitle.Turnip.buyTitle, AppTitle.Turnip.buyForOval) ?? UIView()
        buyBackgroundView.addSubview(buyTopView)
        buyTopView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(buyBackgroundView)
        }
        buyPriceLabel = titlePriceCountLabel(with: AppTitle.Turnip.price)
        buyBackgroundView.addSubview(buyPriceLabel)
        buyPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(buyTopView.snp.bottom).offset(AppContraints.minEdge)
            make.leading.equalTo(buyBackgroundView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(buyBackgroundView.snp.centerX).offset(-AppContraints.CellSizes.cellBgEdge)
        }

        buyPriceTextField = self.makePurchaseTextField(with: .buyPrice, withPlacehoder: AppTitle.Turnip.price, withImageName: AppImage.Turnip.price.rawValue)
        buyBackgroundView.addSubview(buyPriceTextField)
        buyPriceTextField.snp.makeConstraints { make in
            make.top.equalTo(buyPriceLabel.snp.bottom).offset(AppContraints.minEdge)
            make.leading.equalTo(buyBackgroundView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(buyBackgroundView.snp.centerX).offset(-AppContraints.CellSizes.cellBgEdge)
        }
        buyCountLabel = titlePriceCountLabel(with: AppTitle.Turnip.count)
        buyBackgroundView.addSubview(buyCountLabel)
        buyCountLabel.snp.makeConstraints { make in
            make.top.equalTo(buyTopView.snp.bottom).offset(AppContraints.minEdge)
            make.trailing.equalTo(buyBackgroundView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(buyBackgroundView.snp.centerX).offset(AppContraints.CellSizes.cellBgEdge)
        }

        buyCountTextField = self.makePurchaseTextField(with: .buyCount, withPlacehoder: AppTitle.Turnip.count, withImageName: AppImage.Turnip.count.rawValue)
        buyBackgroundView.addSubview(buyCountTextField)
        buyCountTextField.snp.makeConstraints { make in
            make.top.equalTo(buyCountLabel.snp.bottom).offset(AppContraints.minEdge)
            make.trailing.equalTo(buyBackgroundView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(buyBackgroundView.snp.centerX).offset(AppContraints.CellSizes.cellBgEdge)
        }

        buyCalculateButton = OvalButton(withTitle: AppTitle.Turnip.expense,
										width: AppContraints.Turnip.priceTFWidth,
										height: AppContraints.Turnip.heightButton,
										color: self.colors)
        buyBackgroundView.addSubview(buyCalculateButton)
        buyCalculateButton.snp.makeConstraints { make in
            make.top.equalTo(buyCountTextField.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(buyBackgroundView)
            make.bottom.equalTo(buyBackgroundView).offset(-AppContraints.midEdge)
        }
    }
// Turnip Calculation
    func setupTurnipArea() {
        self.setupTopTurnipView()
        self.setupBackgroungTurnipView()
        self.makeFirstColumnViews()
        self.makeSecondColumnViews()
        self.makeThirdColumnViews()
    }

    func setupTopTurnipView() {
        contentScrollView.addSubview(turnipBackgroundView)
        turnipBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(buyBackgroundView.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(contentScrollView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(contentScrollView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.width.equalTo(contentScrollView).offset(AppContraints.CellSizes.widthOffset)
        }
        turnipBackgroundView.backgroundColor = colors?.cellColorSet.backgroundViewColor
        turnipBackgroundView.layer.cornerRadius = AppContraints.CellSizes.cellCornerRadius
        turnipBackgroundView.layer.masksToBounds = true
        turnipTopView = customView?.setupTopView(text: AppTitle.Turnip.turnipTitle, AppTitle.Turnip.turnipForOval) ?? UIView()
        turnipBackgroundView.addSubview(turnipTopView)
        turnipTopView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(turnipBackgroundView)
        }
    }

    func setupBackgroungTurnipView() {
        turnipBackgroundView.addSubview(firstTurnipColumn)
        firstTurnipColumn.snp.makeConstraints { make in
            make.top.equalTo(turnipTopView.snp.bottom)
            make.leading.equalTo(turnipBackgroundView)
            make.width.equalTo(AppContraints.Turnip.columnWidth)
        }
        turnipBackgroundView.addSubview(secondTurnipColumn)
        secondTurnipColumn.snp.makeConstraints { make in
            make.top.equalTo(turnipTopView.snp.bottom)
            make.leading.equalTo(firstTurnipColumn.snp.trailing)
            make.width.equalTo(AppContraints.Turnip.columnWidth)
        }
        turnipBackgroundView.addSubview(thirdTurnipColumn)
        thirdTurnipColumn.snp.makeConstraints { make in
            make.top.equalTo(turnipTopView.snp.bottom)
            make.leading.equalTo(secondTurnipColumn.snp.trailing)
            make.trailing.equalTo(turnipBackgroundView)
            make.width.equalTo(AppContraints.Turnip.columnWidth)
        }
        secondTurnipColumn.addSubview(morningView)
        morningView.snp.makeConstraints { make in
            make.centerX.equalTo(secondTurnipColumn)
            make.top.equalTo(secondTurnipColumn).offset(AppContraints.midEdge)
            make.height.equalTo(AppContraints.Turnip.weekViewHeight)
            make.width.equalTo(AppContraints.Turnip.weekViewWidth)
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
            make.top.equalTo(thirdTurnipColumn).offset(AppContraints.midEdge)
            make.height.equalTo(AppContraints.Turnip.weekViewHeight)
            make.width.equalTo(AppContraints.Turnip.weekViewWidth)
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

        turnipPriceCalculateButton = OvalButton(withTitle: AppTitle.Turnip.turnipPrice,
												width: AppContraints.Turnip.priceTFWidth,
												height: AppContraints.Turnip.heightButton,
												color: self.colors)
        turnipBackgroundView.addSubview(turnipPriceCalculateButton)
        turnipPriceCalculateButton.snp.makeConstraints { make in
            make.top.equalTo(firstTurnipColumn.snp.bottom).offset(AppContraints.midEdge)
            make.top.equalTo(secondTurnipColumn.snp.bottom).offset(AppContraints.midEdge)
            make.top.equalTo(thirdTurnipColumn.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(turnipBackgroundView)
            make.bottom.equalTo(turnipBackgroundView).offset(-AppContraints.midEdge)
        }
    }

    func makeFirstColumnViews() {
        let monText = self.presenter.dateForView(forDayWeek: .monday)
        monView = WeekView.setupWeekView(weekDayText: monText, colors: colors)
        firstTurnipColumn.addSubview(monView)
        monView.snp.makeConstraints { make in
            make.top.equalTo(firstTurnipColumn).offset(AppContraints.Turnip.monViewOffset)
            make.centerX.equalTo(firstTurnipColumn)
            make.height.equalTo(AppContraints.Turnip.weekViewHeight)
            make.width.equalTo(AppContraints.Turnip.weekViewWidth)
        }
        let tueText = self.presenter.dateForView(forDayWeek: .tuesday)
        tueView = WeekView.setupWeekView(weekDayText: tueText, colors: colors)
        firstTurnipColumn.addSubview(tueView)
        tueView.snp.makeConstraints { make in
            make.top.equalTo(monView.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(firstTurnipColumn)
            make.height.equalTo(AppContraints.Turnip.weekViewHeight)
            make.width.equalTo(AppContraints.Turnip.weekViewWidth)
        }
        let wedText = self.presenter.dateForView(forDayWeek: .wednesday)
        wedView = WeekView.setupWeekView(weekDayText: wedText, colors: colors)
        firstTurnipColumn.addSubview(wedView)
        wedView.snp.makeConstraints { make in
            make.top.equalTo(tueView.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(firstTurnipColumn)
            make.height.equalTo(AppContraints.Turnip.weekViewHeight)
            make.width.equalTo(AppContraints.Turnip.weekViewWidth)
        }
        let thuText = self.presenter.dateForView(forDayWeek: .thursday)
        thuView = WeekView.setupWeekView(weekDayText: thuText, colors: colors)
        firstTurnipColumn.addSubview(thuView)
        thuView.snp.makeConstraints { make in
            make.top.equalTo(wedView.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(firstTurnipColumn)
            make.height.equalTo(AppContraints.Turnip.weekViewHeight)
            make.width.equalTo(AppContraints.Turnip.weekViewWidth)
        }
        let friText = self.presenter.dateForView(forDayWeek: .friday)
        friView = WeekView.setupWeekView(weekDayText: friText, colors: colors)
        firstTurnipColumn.addSubview(friView)
        friView.snp.makeConstraints { make in
            make.top.equalTo(thuView.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(firstTurnipColumn)
            make.height.equalTo(AppContraints.Turnip.weekViewHeight)
            make.width.equalTo(AppContraints.Turnip.weekViewWidth)
        }
        let satText = self.presenter.dateForView(forDayWeek: .saturday)
        satView = WeekView.setupWeekView(weekDayText: satText, colors: colors)
        firstTurnipColumn.addSubview(satView)
        satView.snp.makeConstraints { make in
            make.top.equalTo(friView.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(firstTurnipColumn)
            make.height.equalTo(AppContraints.Turnip.weekViewHeight)
            make.width.equalTo(AppContraints.Turnip.weekViewWidth)
            make.bottom.equalTo(firstTurnipColumn).offset(-AppContraints.midEdge)
        }
    }

    func makeSecondColumnViews() {
        monMorTextField = self.makeTurnipPriceTextField(with: .mondayMorning)
        secondTurnipColumn.addSubview(monMorTextField)
        monMorTextField.snp.makeConstraints { make in
            make.top.equalTo(morningView.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(secondTurnipColumn)
        }
        tueMorTextField = self.makeTurnipPriceTextField(with: .tuesdayMorning)
        secondTurnipColumn.addSubview(tueMorTextField)
        tueMorTextField.snp.makeConstraints { make in
            make.top.equalTo(monMorTextField.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(secondTurnipColumn)
        }
        wedMorTextField = self.makeTurnipPriceTextField(with: .wednesdayMorning)
        secondTurnipColumn.addSubview(wedMorTextField)
        wedMorTextField.snp.makeConstraints { make in
            make.top.equalTo(tueMorTextField.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(secondTurnipColumn)
        }
        thuMorTextField = self.makeTurnipPriceTextField(with: .thursdayMorning)
        secondTurnipColumn.addSubview(thuMorTextField)
        thuMorTextField.snp.makeConstraints { make in
            make.top.equalTo(wedMorTextField.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(secondTurnipColumn)
        }
        friMorTextField = self.makeTurnipPriceTextField(with: .fridayMorning)
        secondTurnipColumn.addSubview(friMorTextField)
        friMorTextField.snp.makeConstraints { make in
            make.top.equalTo(thuMorTextField.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(secondTurnipColumn)
        }
        satMorTextField = self.makeTurnipPriceTextField(with: .saturdayMorning)
        secondTurnipColumn.addSubview(satMorTextField)
        satMorTextField.snp.makeConstraints { make in
            make.top.equalTo(friMorTextField.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(secondTurnipColumn)
            make.bottom.equalTo(secondTurnipColumn).offset(-AppContraints.midEdge)
        }
    }

    func makeThirdColumnViews() {
        monEveTextField = self.makeTurnipPriceTextField(with: .mondayEvening)
        thirdTurnipColumn.addSubview(monEveTextField)
        monEveTextField.snp.makeConstraints { make in
            make.top.equalTo(eveningView.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(thirdTurnipColumn)
        }
        tueEveTextField = self.makeTurnipPriceTextField(with: .tuesdayEvening)
        thirdTurnipColumn.addSubview(tueEveTextField)
        tueEveTextField.snp.makeConstraints { make in
            make.top.equalTo(monEveTextField.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(thirdTurnipColumn)
        }
        wedEveTextField = self.makeTurnipPriceTextField(with: .wednesdayEvening)
        thirdTurnipColumn.addSubview(wedEveTextField)
        wedEveTextField.snp.makeConstraints { make in
            make.top.equalTo(tueEveTextField.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(thirdTurnipColumn)
        }
        thuEveTextField = self.makeTurnipPriceTextField(with: .thursdayEvening)
        thirdTurnipColumn.addSubview(thuEveTextField)
        thuEveTextField.snp.makeConstraints { make in
            make.top.equalTo(wedEveTextField.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(thirdTurnipColumn)
        }
        friEveTextField = self.makeTurnipPriceTextField(with: .fridayEvening)
        thirdTurnipColumn.addSubview(friEveTextField)
        friEveTextField.snp.makeConstraints { make in
            make.top.equalTo(thuEveTextField.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(thirdTurnipColumn)
        }
        satEveTextField = self.makeTurnipPriceTextField(with: .saturdayEvening)
        thirdTurnipColumn.addSubview(satEveTextField)
        satEveTextField.snp.makeConstraints { make in
            make.top.equalTo(friEveTextField.snp.bottom).offset(AppContraints.minEdge)
            make.centerX.equalTo(thirdTurnipColumn)
            make.bottom.equalTo(thirdTurnipColumn).offset(-AppContraints.midEdge)
        }
    }
// Sell View
    func setupSellArea() {
        contentScrollView.addSubview(sellBackgroundView)
        sellBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(turnipBackgroundView.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(contentScrollView).offset(AppContraints.CellSizes.cellBgEdge)
            make.bottom.equalTo(contentScrollView.snp.bottom).offset(-AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(contentScrollView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.width.equalTo(contentScrollView).offset(AppContraints.CellSizes.widthOffset)
        }
        sellBackgroundView.backgroundColor = colors?.cellColorSet.backgroundViewColor
        sellBackgroundView.layer.cornerRadius = AppContraints.CellSizes.cellCornerRadius
        sellBackgroundView.layer.masksToBounds = true
        sellTopView = customView?.setupTopView(text: AppTitle.Turnip.sellTitle, AppTitle.Turnip.sellForOval) ?? UIView()
        sellBackgroundView.addSubview(sellTopView)
        sellTopView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(sellBackgroundView)
        }
        sellPriceLabel = titlePriceCountLabel(with: AppTitle.Turnip.price)
        sellBackgroundView.addSubview(sellPriceLabel)
        sellPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(sellTopView.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(sellBackgroundView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(sellBackgroundView.snp.centerX).offset(-AppContraints.CellSizes.cellBgEdge)
        }
        sellCountLabel = titlePriceCountLabel(with: AppTitle.Turnip.count)
        sellBackgroundView.addSubview(sellCountLabel)
        sellCountLabel.snp.makeConstraints { make in
            make.top.equalTo(sellTopView.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(sellBackgroundView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(sellBackgroundView.snp.centerX).offset(AppContraints.CellSizes.cellBgEdge)
        }
        sellPriceTextField = self.makePurchaseTextField(with: .sellPrice, withPlacehoder: AppTitle.Turnip.sell, withImageName: AppImage.Turnip.sell.rawValue)
        sellBackgroundView.addSubview(sellPriceTextField)
        sellPriceTextField.snp.makeConstraints { make in
            make.top.equalTo(sellPriceLabel.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(sellBackgroundView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(sellBackgroundView.snp.centerX).offset(-AppContraints.CellSizes.cellBgEdge)
        }
        sellCountTextField = self.makePurchaseTextField(with: .sellCount,
														withPlacehoder: AppTitle.Turnip.count,
														withImageName: AppImage.Turnip.count.rawValue)
        sellBackgroundView.addSubview(sellCountTextField)
        sellCountTextField.snp.makeConstraints { make in
            make.top.equalTo(sellCountLabel.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(sellBackgroundView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(sellBackgroundView.snp.centerX).offset(AppContraints.CellSizes.cellBgEdge)
        }
        sellCalculateButton = OvalButton(withTitle: AppTitle.Turnip.income,
										 width: AppContraints.Turnip.heightButton,
										 height: AppContraints.Turnip.heightButton,
										 color: self.colors)
        sellBackgroundView.addSubview(sellCalculateButton)
        sellCalculateButton.snp.makeConstraints { make in
            make.top.equalTo(sellCountTextField.snp.bottom).offset(AppContraints.midEdge)
            make.top.equalTo(sellPriceTextField.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(sellBackgroundView)
            make.bottom.equalTo(sellBackgroundView).offset(-AppContraints.midEdge)
        }
    }
}
// ITurnipViewController protocol
extension TurnipViewController: ITurnipViewController {
}

// Buttons Methods
@objc extension TurnipViewController {
	func buyCalculateButtonTapped(sender: UIButton) {
        self.presenter.buyCalculateButtonTapped(buyPrice: buyPriceTextField.text, turnipCount: buyCountTextField.text)
    }
    func turnipPriceCalculateButtonTapped(sender: UIButton) {
        self.presenter.turnipPriceCalculateButtonTapped(mondayMorning: monMorTextField.text,
                                                        mondayEvening: monEveTextField.text,
                                                        tuesdayMorning: tueMorTextField.text,
                                                        tuesdayEvening: tueEveTextField.text,
                                                        wednesdayMorning: wedMorTextField.text,
                                                        wednesdayEvening: wedEveTextField.text,
                                                        thursdayMorning: thuMorTextField.text,
                                                        thursdayEvening: thuEveTextField.text,
                                                        fridayMorning: friMorTextField.text,
                                                        fridayEvening: friEveTextField.text,
                                                        saturdayMorning: satMorTextField.text,
                                                        saturdayEvening: satEveTextField.text)
    }

    func sellCalculateButtonTapped(sender: UIButton) {
        self.presenter.sellCalculateButtonTapped(sellPrice: sellPriceTextField.text, turnipCount: sellCountTextField.text)
    }
}

// MARK: - Reusible View
fileprivate extension TurnipViewController {
    func makePurchaseTextField(with text: TurnipTextFieldText, withPlacehoder placeholder: String, withImageName imageName: String) -> UITextField {
        let textfield = UITextField()
        textfield.keyboardType = .default
        textfield.placeholder = placeholder
        textfield.font = ACFont.purchaseFont.font
        textfield.textColor = colors?.textfieldColor.textColor
        textfield.layer.cornerRadius = AppContraints.Turnip.cornerRadius
        textfield.backgroundColor = colors?.textfieldColor.backgroundColor
        textfield.layer.borderWidth = 0.5
        textfield.layer.borderColor = colors?.textfieldColor.borderColor
        let view = customView?.makeImageLeftViewTF(withImageName: imageName) ?? UIView()
        textfield.leftViewMode = .always
        textfield.leftView = view
        textfield.snp.makeConstraints { make in
            make.height.equalTo(AppContraints.Turnip.heightTF)
        }
        textfield.rightViewMode = .always
        textfield.rightView = UIView(frame: CGRect(x: 0, y: 0, width: AppContraints.midEdge, height: textfield.frame.height))
        let textTF = self.presenter.dataForTextField(for: text)
        textfield.text = textTF
        return textfield
    }

    func makeTurnipPriceTextField(with text: TurnipTextFieldText) -> UITextField {
        let textfield = UITextField()
        textfield.keyboardType = .default
        textfield.font = ACFont.priceFont.font
        textfield.textColor = colors?.textfieldColor.textColor
        textfield.layer.cornerRadius = AppContraints.Turnip.cornerRadius
        textfield.backgroundColor = colors?.textfieldColor.backgroundColor
        textfield.layer.borderWidth = 0.5
        textfield.layer.borderColor = colors?.textfieldColor.borderColor
        textfield.textAlignment = .center
        textfield.leftViewMode = .always
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: AppContraints.midEdge, height: textfield.frame.height))
        textfield.snp.makeConstraints { make in
            make.height.equalTo(AppContraints.Turnip.weekViewHeight)
            make.width.equalTo(AppContraints.Turnip.weekViewWidth)
        }
        textfield.rightViewMode = .always
        textfield.rightView = UIView(frame: CGRect(x: 0, y: 0, width: AppContraints.midEdge, height: textfield.frame.height))
        let textTF = self.presenter.dataForTextField(for: text)
        textfield.text = textTF
        return textfield
    }

    func titlePriceCountLabel(with text: String) -> UILabel {
       let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = ACFont.priceFont.font 
        label.textColor = colors?.cellColorSet.itemTextColor
        return label
    }
}
