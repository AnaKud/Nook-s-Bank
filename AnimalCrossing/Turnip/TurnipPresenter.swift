//
//  TurnipPresenter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 27.06.2021.
//

import Foundation

protocol ITurnipPresenter {
    var screenType: ScreenTypes? { get set }
    func loadView(with view: ITurnipViewController)
    func dateForView(forDayWeek dayWeek: WeekDay) -> String?
    func dataForTextField(for textFiled: TurnipTextFieldText) -> String
    func buyCalculateButtonTapped(buyPrice: String?, turnipCount: String?)
    func turnipPriceCalculateButtonTapped(mondayMorning: String?, mondayEvening: String?, tuesdayMorning: String?, tuesdayEvening: String?, wednesdayMorning: String?, wednesdayEvening: String?, thursdayMorning: String?, thursdayEvening: String?, fridayMorning: String?, fridayEvening: String?, saturdayMorning: String?, saturdayEvening: String?)
    func sellCalculateButtonTapped(sellPrice: String?, turnipCount: String?)
}

class TurnipPresenter: ITurnipPresenter {
    
    var firebaseManager: ITurnipFireBaseManager
    var coreDataManger: ITurnipCoreDataManager
    var router: ITurnipRouter
    
    var screenType: ScreenTypes?
    var turnipPrices: TurnipPrices?
    var turnipCoreData: TurnipPrices?
    var lastSunday = DatesOfCurrentWeek().getLastSunday()
    var dates = DatesOfCurrentWeek().getWeekDates()
    var view: ITurnipViewController?
    
    init(firebaseManager: ITurnipFireBaseManager, coreDataManger: ITurnipCoreDataManager, router: ITurnipRouter) {
        self.firebaseManager = firebaseManager
        self.coreDataManger = coreDataManger
        self.router = router
        self.checkToCleanCoreData()
    }
    
    func loadView(with view: ITurnipViewController){
        self.view = view
    }
    
    func buyCalculateButtonTapped(buyPrice: String?, turnipCount: String?) {
        guard let buyPrice = buyPrice,
              let price = Int(buyPrice)
        else {
            self.view?.showErrorAlert(withMessage: .turnipPriceError)
            return
        }
        let turnipCount: Int? = Int(turnipCount ?? "0")
        if self.turnipPrices == nil {
            let turnip = TurnipPrices(sundayDate: self.lastSunday, buyPrice: price, turnipCount: turnipCount)
            self.turnipPrices = turnip
            self.addToCoreData()
            self.addDataToFireBase(price: price, count: turnipCount, operationType: .minus)
            
        } else {
            let turnip = TurnipPrices(sunday: self.turnipPrices?.sundayDate, buyPrice: price, turnipCount: turnipCount, mondayMorning: self.turnipPrices?.mondayMorning, mondayEvening: self.turnipPrices?.mondayEvening, tuesdayMorning: self.turnipPrices?.tuesdayMorning, tuesdayEvening: self.turnipPrices?.tuesdayEvening, wednesdayMorning: self.turnipPrices?.wednesdayMorning, wednesdayEvening: self.turnipPrices?.wednesdayEvening, thursdayMorning: self.turnipPrices?.thursdayMorning, thursdayEvening: self.turnipPrices?.thursdayEvening, fridayMorning: self.turnipPrices?.fridayMorning, fridayEvening: self.turnipPrices?.fridayEvening, saturdayMorning: self.turnipPrices?.saturdayMorning, saturdayEvening: self.turnipPrices?.saturdayEvening, sellPrice: self.turnipPrices?.sellPrice)
            self.turnipPrices = turnip
            self.updateToCoreData()
        }
    }
    
    func turnipPriceCalculateButtonTapped(mondayMorning: String?, mondayEvening: String?, tuesdayMorning: String?, tuesdayEvening: String?, wednesdayMorning: String?, wednesdayEvening: String?, thursdayMorning: String?, thursdayEvening: String?, fridayMorning: String?, fridayEvening: String?, saturdayMorning: String?, saturdayEvening: String?) {
        let prices = TurnipPrices(sundayDate: self.turnipPrices?.sundayDate, buyPrice: self.turnipPrices?.buyPrice ?? 0, turnipCount: self.turnipPrices?.buyPrice, mondayMorning: mondayMorning, mondayEvening: mondayEvening, tuesdayMorning: tuesdayMorning, tuesdayEvening: tuesdayEvening, wednesdayMorning: wednesdayMorning, wednesdayEvening: wednesdayEvening, thursdayMorning: thursdayMorning, thursdayEvening: thursdayEvening, fridayMorning: fridayMorning, fridayEvening: fridayEvening, saturdayMorning: saturdayMorning, saturdayEvening: saturdayEvening, sellPrice: self.turnipPrices?.sellPrice)
        
        self.turnipPrices = prices
        self.updateToCoreData()
        self.router.routeToProphetPricesVC(with: prices)
    }
    
    func sellCalculateButtonTapped(sellPrice: String?, turnipCount: String?) {
        print("sellPrice")
    }
    
    func dateForView(forDayWeek dayWeek: WeekDay) -> String? {
        switch dayWeek {
        case .monday:
            return dates?[dayWeek.rawValue]
        case .tuesday:
            return dates?[dayWeek.rawValue]
        case .wednesday:
            return dates?[dayWeek.rawValue]
        case .thursday:
            return dates?[dayWeek.rawValue]
        case .friday:
            return dates?[dayWeek.rawValue]
        case .saturday:
            return dates?[dayWeek.rawValue]
        }
    }
    
    func dataForTextField(for textFiled: TurnipTextFieldText) -> String {
        var number: Int?
        switch textFiled {
        case .buyPrice:
            number = turnipPrices?.buyPrice
        case .buyCount:
            number = turnipPrices?.turnipCount
        case .mondayMorning:
            number = turnipPrices?.mondayMorning
        case .mondayEvening:
            number = turnipPrices?.mondayEvening
        case .tuesdayMorning:
            number = turnipPrices?.tuesdayMorning
        case .tuesdayEvening:
            number = turnipPrices?.tuesdayEvening
        case .wednesdayMorning:
            number = turnipPrices?.wednesdayMorning
        case .wednesdayEvening:
            number = turnipPrices?.wednesdayEvening
        case .thursdayMorning:
            number = turnipPrices?.thursdayMorning
        case .thursdayEvening:
            number = turnipPrices?.thursdayEvening
        case .fridayMorning:
            number = turnipPrices?.fridayMorning
        case .fridayEvening:
            number = turnipPrices?.fridayEvening
        case .saturdayMorning:
            number = turnipPrices?.saturdayMorning
        case .saturdayEvening:
            number = turnipPrices?.saturdayEvening
        case .sellPrice:
            number = turnipPrices?.sellPrice
        case .sellCount:
            number = nil
        }
        if let num = number, num != 0 {
            return "\(num)"
        } else {
            return ""
        }
    }
    
    private func addDataToFireBase(price: Int, count: Int?, operationType: OperationType) {
        guard let count = count, count > 0 else { return }
        let value = price * count
        let expense = ExpenseFB(value: value, operationType: operationType, expenseType: .Turnip)
        switch screenType {
        case .loggined:
            self.firebaseManager.addExpenseToFb(expense: expense)
        default:
            switch operationType {
            case .plus:
                let currentValue = DemoBankData.account.currentValue + value
                DemoBankData.account.currentValue = currentValue
                DemoBankData.account.expenses?.append(ExpenseViewModel(value: value, operationType: operationType, expenseType: .Turnip))
            case .minus:
                let currentValue = DemoBankData.account.currentValue - value
                DemoBankData.account.currentValue = currentValue
                DemoBankData.account.expenses?.append(ExpenseViewModel(value: value, operationType: operationType, expenseType: .Turnip))
            }
        }
    }
    
    private func addToCoreData() {
        guard let turnipPrices = self.turnipPrices else {
            print(" core data error")
            return
        }
        self.coreDataManger.addTurnip(turnip: turnipPrices)
    }
    
    private func updateToCoreData() {
        guard let turnipPrices = self.turnipPrices else {
            print(" core data error")
            return
        }
        self.coreDataManger.updateTurnip(turnip: turnipPrices)
    }
    
    private func fetchTurnipFromCoreData() {
        self.turnipCoreData = self.coreDataManger.loadTurnip()
    }
    
    private func checkToCleanCoreData() {
        self.fetchTurnipFromCoreData()
        if turnipCoreData?.sundayDate != lastSunday {
            self.coreDataManger.deleteTurnip()
            self.turnipCoreData = nil
        } else {
            self.turnipPrices = self.turnipCoreData
        }
    }
}
