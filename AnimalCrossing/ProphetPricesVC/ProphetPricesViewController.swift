//
//  ProphetPricesViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 08.07.2021.
//  Copyright (c) 2021  All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SwiftUI
import SwiftUICharts

protocol IProphetPricesViewController: AnyObject {
    func displayDateViews(dates: ProphetPrices.Turnip.ViewModel.Dates)
    func displayPrices(prices: ProphetPrices.Turnip.ViewModel.Prices)
    func displayGraph(with data: ProphetPrices.Turnip.ViewModel.PriceForGraph)
    func displayAll()
    func displayEmptyScreen()
}

class ProphetPricesViewController: CustomViewController {
    var interactor: IProphetPricesInteractorBusinessLogic
    
    // Views
    var emptyImageView = UIImageView()
    var emptyLabel = UILabel()
    
    var contentScrollView = UIScrollView()
    var priceBackgroundView = UIView()
    var priceTopView = UIView()
    
    var morningView = UIView()
    var eveningView = UIView()
    var morningImageView = UIImageView()
    var eveningImageView = UIImageView()
    var firstTurnipColumn = UIView()
    var secondTurnipColumn = UIView()
    var thirdTurnipColumn = UIView()
    
    var monView = UIView()
    var monMorPriceView = UIView()
    var monEvePriceView = UIView()
    var tueView = UIView()
    var tueMorPriceView = UIView()
    var tueEvePriceView = UIView()
    var wedView = UIView()
    var wedMorPriceView = UIView()
    var wedEvePriceView = UIView()
    var thuView = UIView()
    var thuMorPriceView = UIView()
    var thuEvePriceView = UIView()
    var friView = UIView()
    var friMorPriceView = UIView()
    var friEvePriceView = UIView()
    var satView = UIView()
    var satMorPriceView = UIView()
    var satEvePriceView = UIView()
    
    var priceMinValueView = UIView()
    var priceMinValueLabel = UILabel()
    
    var graphBackgroundView = UIView()
    var graphTopView = UIView()
    var graphView = UIView()
    var graphDataView: GraphView!
    
    // MARK: Object lifecycle
    
    init(interactor: IProphetPricesInteractorBusinessLogic) {
        self.interactor = interactor
        
        super.init(nibName: nil, bundle: nil)
        self.screenType = .other
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // view.backgroundColor = .red
        doSomething()
        setupScrollView()
        
    }
    
    // MARK: Do something
    
    func doSomething() {
        interactor.makeTurnipPricesRequest()
        
    }
    
    
}

extension ProphetPricesViewController: IProphetPricesViewController {
    func displayGraph(with data: ProphetPrices.Turnip.ViewModel.PriceForGraph) {
        graphDataView = GraphView(data: data.pricesData)
    }
    
    func displayAll() {
        DispatchQueue.main.async {
            self.emptyLabel.isHidden = true
            self.emptyImageView.isHidden = true
            self.priceBackgroundView.isHidden = false
            self.graphBackgroundView.isHidden = false
            self.makeFirstColumnViews()
            self.makeSecondColumnViews()
            self.makeThirdColumnViews()
            self.setupPriceMinValueView()
            self.setupGraphView()
        }
    }
    
    func displayEmptyScreen() {
        DispatchQueue.main.async {
            self.emptyLabel.isHidden = false
            self.emptyImageView.isHidden = false
            self.priceBackgroundView.isHidden = true
            self.graphBackgroundView.isHidden = true
            self.setupEmptyScreen()
        }
    }
    
    private func setupEmptyScreen() {
        contentScrollView.isScrollEnabled = false
        contentScrollView.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(contentScrollView)
            make.width.equalTo(contentScrollView)
        }
        emptyLabel.text = AppTitle.Prophet.emptyLabel
        emptyLabel.textColor = colors?.cellColorSet.topViewColor
        emptyLabel.textAlignment = .center
        emptyLabel.numberOfLines = 0
        emptyLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 20)
        
        contentScrollView.addSubview(emptyImageView)
        emptyImageView.snp.makeConstraints { make in
            make.bottom.equalTo(emptyLabel.snp.top).offset(-AppContraints.midEdge)
            make.centerX.equalTo(contentScrollView)
            make.height.equalTo(100)
        }
        emptyImageView.image = UIImage(named: AppImage.Prices.daisyMae.rawValue)
    }
    
    func displayDateViews(dates: ProphetPrices.Turnip.ViewModel.Dates) {
        let monText = dates.dateForView(forDayWeek: .monday)
        let tueText = dates.dateForView(forDayWeek: .tuesday)
        let wedText = dates.dateForView(forDayWeek: .wednesday)
        let thuText = dates.dateForView(forDayWeek: .thursday)
        let friText = dates.dateForView(forDayWeek: .friday)
        let satText = dates.dateForView(forDayWeek: .saturday)
        
        DispatchQueue.main.async {
            self.monView = WeekView.setupWeekView(weekDayText: monText, colors: self.colors)
            self.tueView = WeekView.setupWeekView(weekDayText: tueText, colors: self.colors)
            self.wedView = WeekView.setupWeekView(weekDayText: wedText, colors: self.colors)
            self.thuView = WeekView.setupWeekView(weekDayText: thuText, colors: self.colors)
            self.friView = WeekView.setupWeekView(weekDayText: friText, colors: self.colors)
            self.satView = WeekView.setupWeekView(weekDayText: satText, colors: self.colors)
            self.setupPriceView()
        }
        
    }
    func displayPrices(prices: ProphetPrices.Turnip.ViewModel.Prices) {
        let monMorPrices = prices.getDayPrice(for: .mondayMorning)
        let monEvePrices = prices.getDayPrice(for: .mondayEvening)
        let tueMorPrices = prices.getDayPrice(for: .tuesdayMorning)
        let tueEvePrices = prices.getDayPrice(for: .tuesdayEvening)
        let wedMorPrices = prices.getDayPrice(for: .wednesdayMorning)
        let wedEvePrices = prices.getDayPrice(for: .wednesdayEvening)
        let thuMorPrices = prices.getDayPrice(for: .thursdayMorning)
        let thuEvePrices = prices.getDayPrice(for: .thursdayEvening)
        let friMorPrices = prices.getDayPrice(for: .fridayMorning)
        let friEvePrices = prices.getDayPrice(for: .fridayEvening)
        let satMorPrices = prices.getDayPrice(for: .saturdayMorning)
        let satEvePrices = prices.getDayPrice(for: .saturdayEvening)
        
        DispatchQueue.main.async {
            self.monMorPriceView = self.makePriceView(prices: monMorPrices)
            self.monEvePriceView = self.makePriceView(prices: monEvePrices)
            
            self.tueMorPriceView = self.makePriceView(prices: tueMorPrices)
            self.tueEvePriceView = self.makePriceView(prices: tueEvePrices)
            
            self.wedMorPriceView = self.makePriceView(prices: wedMorPrices)
            self.wedEvePriceView = self.makePriceView(prices: wedEvePrices)
            
            self.thuMorPriceView = self.makePriceView(prices: thuMorPrices)
            self.thuEvePriceView = self.makePriceView(prices: thuEvePrices)
            
            self.friMorPriceView = self.makePriceView(prices: friMorPrices)
            self.friEvePriceView = self.makePriceView(prices: friEvePrices)
            
            self.satMorPriceView = self.makePriceView(prices: satMorPrices)
            self.satEvePriceView = self.makePriceView(prices: satEvePrices)
            self.priceMinValueLabel.text = AppTitle.Prophet.priceMinValue + "\( prices.minimumPrice)"
        }
    }
}

extension ProphetPricesViewController: UIScrollViewDelegate {
    func setupScrollView() {
        view.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view)
        }
        contentScrollView.delegate = self
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        
    }
}

fileprivate extension ProphetPricesViewController {
    func setupPriceView() {
        contentScrollView.addSubview(priceBackgroundView)
        priceBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(contentScrollView).offset(AppContraints.CellSizes.cellMaxEdge)
            make.leading.equalTo(contentScrollView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(contentScrollView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.width.equalTo(contentScrollView).offset(AppContraints.CellSizes.widthOffset)
        }
        priceBackgroundView.backgroundColor = colors?.cellColorSet.backgroundViewColor
        priceBackgroundView.layer.cornerRadius = AppContraints.CellSizes.cellCornerRadius
        priceBackgroundView.layer.masksToBounds = true
        priceTopView = customView?.setupTopView(text: AppTitle.Prophet.priceTitle, AppTitle.Prophet.priceForOval) ?? UIView()
        priceBackgroundView.addSubview(priceTopView)
        priceTopView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(priceBackgroundView)
        }
        priceBackgroundView.addSubview(firstTurnipColumn)
        firstTurnipColumn.snp.makeConstraints { make in
            make.top.equalTo(priceTopView.snp.bottom)
            make.leading.equalTo(priceBackgroundView)
            make.width.equalTo(AppContraints.ProphetPrices.columnWidth)
        }
        priceBackgroundView.addSubview(secondTurnipColumn)
        secondTurnipColumn.snp.makeConstraints { make in
            make.top.equalTo(priceTopView.snp.bottom)
            make.leading.equalTo(firstTurnipColumn.snp.trailing)
            make.width.equalTo(AppContraints.ProphetPrices.columnWidth)
        }
        priceBackgroundView.addSubview(thirdTurnipColumn)
        thirdTurnipColumn.snp.makeConstraints { make in
            make.top.equalTo(priceTopView.snp.bottom)
            make.leading.equalTo(secondTurnipColumn.snp.trailing)
            make.trailing.equalTo(priceBackgroundView)
            make.width.equalTo(AppContraints.ProphetPrices.columnWidth)
        }
        secondTurnipColumn.addSubview(morningView)
        morningView.snp.makeConstraints { make in
            make.centerX.equalTo(secondTurnipColumn)
            make.top.equalTo(secondTurnipColumn).offset(AppContraints.midEdge)
            make.height.equalTo(AppContraints.ProphetPrices.weekViewHeight)
            make.width.equalTo(AppContraints.ProphetPrices.weekViewWidth)
        }
        morningView.backgroundColor = colors?.cellColorSet.topViewColor
        morningView.layer.cornerRadius = AppContraints.ProphetPrices.cornerRadius
        morningView.layer.masksToBounds = true
        
        morningView.addSubview(morningImageView)
        morningImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(morningView)
            make.height.width.equalTo(AppContraints.ProphetPrices.imageWidthHeight)
        }
        morningImageView.image = UIImage(systemName: AppImage.Turnip.morning.rawValue)
        morningImageView.tintColor = colors?.cellColorSet.titleTextColor
        
        thirdTurnipColumn.addSubview(eveningView)
        eveningView.snp.makeConstraints { make in
            make.centerX.equalTo(thirdTurnipColumn)
            make.top.equalTo(thirdTurnipColumn).offset(AppContraints.midEdge)
            make.height.equalTo(AppContraints.ProphetPrices.weekViewHeight)
            make.width.equalTo(AppContraints.ProphetPrices.weekViewWidth)
        }
        eveningView.backgroundColor = colors?.cellColorSet.topViewColor
        eveningView.layer.cornerRadius = AppContraints.ProphetPrices.cornerRadius
        eveningView.layer.masksToBounds = true
        
        eveningView.addSubview(eveningImageView)
        eveningImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(eveningView)
            make.height.width.equalTo(AppContraints.ProphetPrices.imageWidthHeight)
        }
        eveningImageView.image = UIImage(systemName: AppImage.Turnip.evening.rawValue)
        eveningImageView.tintColor = colors?.cellColorSet.titleTextColor
    }
    
    func makeFirstColumnViews() {
        firstTurnipColumn.addSubview(monView)
        monView.snp.makeConstraints { make in
            make.top.equalTo(firstTurnipColumn).offset(AppContraints.ProphetPrices.monViewOffset)
            make.centerX.equalTo(firstTurnipColumn)
            make.height.equalTo(AppContraints.ProphetPrices.weekViewHeight)
            make.width.equalTo(AppContraints.ProphetPrices.weekViewWidth)
        }
        firstTurnipColumn.addSubview(tueView)
        tueView.snp.makeConstraints { make in
            make.top.equalTo(monView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(firstTurnipColumn)
            make.height.equalTo(AppContraints.ProphetPrices.weekViewHeight)
            make.width.equalTo(AppContraints.ProphetPrices.weekViewWidth)
        }
        firstTurnipColumn.addSubview(wedView)
        wedView.snp.makeConstraints { make in
            make.top.equalTo(tueView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(firstTurnipColumn)
            make.height.equalTo(AppContraints.ProphetPrices.weekViewHeight)
            make.width.equalTo(AppContraints.ProphetPrices.weekViewWidth)
        }
        firstTurnipColumn.addSubview(thuView)
        thuView.snp.makeConstraints { make in
            make.top.equalTo(wedView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(firstTurnipColumn)
            make.height.equalTo(AppContraints.ProphetPrices.weekViewHeight)
            make.width.equalTo(AppContraints.ProphetPrices.weekViewWidth)
        }
        firstTurnipColumn.addSubview(friView)
        friView.snp.makeConstraints { make in
            make.top.equalTo(thuView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(firstTurnipColumn)
            make.height.equalTo(AppContraints.ProphetPrices.weekViewHeight)
            make.width.equalTo(AppContraints.ProphetPrices.weekViewWidth)
        }
        firstTurnipColumn.addSubview(satView)
        satView.snp.makeConstraints { make in
            make.top.equalTo(friView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(firstTurnipColumn)
            make.height.equalTo(AppContraints.ProphetPrices.weekViewHeight)
            make.width.equalTo(AppContraints.ProphetPrices.weekViewWidth)
            make.bottom.equalTo(firstTurnipColumn).offset(-AppContraints.midEdge)
        }
    }
    
    func makeSecondColumnViews() {
        secondTurnipColumn.addSubview(monMorPriceView)
        monMorPriceView.snp.makeConstraints { make in
            make.top.equalTo(morningView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(secondTurnipColumn)
        }
        secondTurnipColumn.addSubview(tueMorPriceView)
        tueMorPriceView.snp.makeConstraints { make in
            make.top.equalTo(monMorPriceView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(secondTurnipColumn)
        }
        secondTurnipColumn.addSubview(wedMorPriceView)
        wedMorPriceView.snp.makeConstraints { make in
            make.top.equalTo(tueMorPriceView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(secondTurnipColumn)
        }
        secondTurnipColumn.addSubview(thuMorPriceView)
        thuMorPriceView.snp.makeConstraints { make in
            make.top.equalTo(wedMorPriceView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(secondTurnipColumn)
        }
        secondTurnipColumn.addSubview(friMorPriceView)
        friMorPriceView.snp.makeConstraints { make in
            make.top.equalTo(thuMorPriceView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(secondTurnipColumn)
        }
        secondTurnipColumn.addSubview(satMorPriceView)
        satMorPriceView.snp.makeConstraints { make in
            make.top.equalTo(friMorPriceView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(secondTurnipColumn)
            make.bottom.equalTo(secondTurnipColumn).offset(-AppContraints.midEdge)
        }
    }
    func makeThirdColumnViews() {
        thirdTurnipColumn.addSubview(monEvePriceView)
        monEvePriceView.snp.makeConstraints { make in
            make.top.equalTo(eveningView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(thirdTurnipColumn)
        }
        thirdTurnipColumn.addSubview(tueEvePriceView)
        tueEvePriceView.snp.makeConstraints { make in
            make.top.equalTo(monEvePriceView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(thirdTurnipColumn)
        }
        thirdTurnipColumn.addSubview(wedEvePriceView)
        wedEvePriceView.snp.makeConstraints { make in
            make.top.equalTo(tueEvePriceView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(thirdTurnipColumn)
        }
        thirdTurnipColumn.addSubview(thuEvePriceView)
        thuEvePriceView.snp.makeConstraints { make in
            make.top.equalTo(wedEvePriceView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(thirdTurnipColumn)
        }
        thirdTurnipColumn.addSubview(friEvePriceView)
        friEvePriceView.snp.makeConstraints { make in
            make.top.equalTo(thuEvePriceView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(thirdTurnipColumn)
        }
        thirdTurnipColumn.addSubview(satEvePriceView)
        satEvePriceView.snp.makeConstraints { make in
            make.top.equalTo(friEvePriceView.snp.bottom).offset(AppContraints.midEdge)
            make.centerX.equalTo(thirdTurnipColumn)
            make.bottom.equalTo(thirdTurnipColumn).offset(-AppContraints.midEdge)
        }
    }
    func setupPriceMinValueView() {
        priceBackgroundView.addSubview(priceMinValueView)
        priceMinValueView.snp.makeConstraints { make in
            make.top.equalTo(secondTurnipColumn.snp.bottom).offset(AppContraints.midEdge)
            make.height.equalTo(AppContraints.ProphetPrices.weekViewHeight)
            make.centerX.equalTo(priceBackgroundView)
            make.bottom.equalTo(priceBackgroundView).offset(-AppContraints.midEdge)
        }
        priceMinValueView.backgroundColor = colors?.cellColorSet.topViewColor
        priceMinValueView.layer.cornerRadius = AppContraints.ProphetPrices.cornerRadius
        priceMinValueView.addSubview(priceMinValueLabel)
        priceMinValueLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(priceMinValueView).offset(AppContraints.minEdge)
            make.trailing.bottom.equalTo(priceMinValueView).offset(-AppContraints.minEdge)
        }
        priceMinValueLabel.textColor = colors?.cellColorSet.titleTextColor
        priceMinValueLabel.textAlignment = .center
        priceMinValueLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 18)
    }
    func setupGraphView() {
        contentScrollView.addSubview(graphBackgroundView)
        graphBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(priceBackgroundView.snp.bottom).offset(AppContraints.CellSizes.cellBgEdge)
            make.leading.equalTo(contentScrollView).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(contentScrollView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.bottom.equalTo(contentScrollView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.width.equalTo(contentScrollView).offset(AppContraints.CellSizes.widthOffset)
        }
        graphBackgroundView.backgroundColor = colors?.cellColorSet.backgroundViewColor
        graphBackgroundView.layer.cornerRadius = AppContraints.CellSizes.cellCornerRadius
        graphBackgroundView.layer.masksToBounds = true
        graphTopView = customView?.setupTopView(text: AppTitle.Prophet.graphTitle, AppTitle.Prophet.graphForOval) ?? UIView()
        graphBackgroundView.addSubview(graphTopView)
        graphTopView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(graphBackgroundView)
        }
        graphBackgroundView.addSubview(graphView)
        graphView.snp.makeConstraints { make in
            make.top.equalTo(graphTopView.snp.bottom).offset(AppContraints.minEdge)
            make.bottom.leading.trailing.equalTo(graphBackgroundView)
        }
        graphView.backgroundColor = .green
        let childView = UIHostingController(rootView: graphDataView?.body)
        addChild(childView)
        graphView.addSubview(childView.view)
        childView.view.snp.makeConstraints { make in
            make.edges.equalTo(graphView)
        }
        
        childView.didMove(toParent: self)
    }
}

// MARK: -  Reusible View
fileprivate extension ProphetPricesViewController {
    func makePriceView(prices: ProphetPrices.Turnip.ViewModel.DayPrices) -> UIView {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.height.equalTo(AppContraints.ProphetPrices.weekViewHeight)
            make.width.equalTo(AppContraints.ProphetPrices.weekViewWidth)
        }
        view.backgroundColor = colors?.cellColorSet.accentColor
        view.layer.cornerRadius = AppContraints.ProphetPrices.cornerRadius
        if let existingPrice = prices.existingPrice {
            let label = UILabel()
            view.addSubview(label)
            label.snp.makeConstraints { make in
                make.top.trailing.leading.bottom.equalTo(view)
            }
            label.textColor = colors?.cellColorSet.topViewColor
            label.text = "\(existingPrice)"
            label.textAlignment = .center
            label.font = UIFont(name: AppFont.maruBold.rawValue, size: 20)
        } else {
            let patternLabel = UILabel()
            view.addSubview(patternLabel)
            patternLabel.snp.makeConstraints { make in
                make.top.leading.equalTo(view).offset(AppContraints.minEdge)
                make.trailing.equalTo(view).offset(-AppContraints.minEdge)
            }
            patternLabel.textColor = colors?.cellColorSet.itemTextColor
            patternLabel.text = "\(prices.patternPrice.first ?? 0) to \(prices.patternPrice.last ?? 0)"
            patternLabel.textAlignment = .right
            patternLabel.font = UIFont(name: AppFont.maruLight.rawValue, size: 14)
            
            let expectedPriceLabel = UILabel()
            view.addSubview(expectedPriceLabel)
            expectedPriceLabel.snp.makeConstraints { make in
                make.top.equalTo(patternLabel.snp.bottom).offset(AppContraints.minEdge)
                make.leading.equalTo(view).offset(AppContraints.minEdge)
                make.trailing.bottom.equalTo(view).offset(-AppContraints.minEdge)
            }
            expectedPriceLabel.textColor = colors?.cellColorSet.itemTextColor
            expectedPriceLabel.text = "Exp: \(prices.expectedPrice)"
            expectedPriceLabel.textAlignment = .left
            expectedPriceLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 14)
        }
        return view
    }
    
    
}