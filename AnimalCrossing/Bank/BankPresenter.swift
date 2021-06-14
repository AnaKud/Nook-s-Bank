//
//  BankPresenter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 13.06.2021.
//

import Foundation


protocol IBankPresenter {
    var user: UserLocale? { get set }
    var account: BankViewModel? { get set }
    var userStatus: UserStatus? { get set }
    
    func getCurrentUser()
    
    func loadView(view: IBankViewController)
    func plusButtonPressed()
    func returnCurrentAccountValue() -> String
    func returnCollectionCount() -> Int
    func returnCollectionItem(index: Int) -> ExpenseViewModel
}

class BankPresenter {
    var userStatus: UserStatus?
    
    var view: IBankViewController?
    
    var account: BankViewModel?
    
    var user: UserLocale?
    
    var fireBaseManager: IBankFireBaseManager
    
    init(fireBaseManager: IBankFireBaseManager) {
        
        self.fireBaseManager = fireBaseManager
        self.user = self.fireBaseManager.getUser()
    }
    
}

extension BankPresenter: IBankPresenter {
    
    
    
    
    func getCurrentUser() {
        switch userStatus {
        case .loggined:
            self.user = self.fireBaseManager.getUser()
            self.getAccountData()
        default:
            self.user = nil
            self.getDemoData()
        }
        self.refreshView()
    }
    
    private func getAccountData() {
        print("add fetch data from fb")
        
    }
    private func getDemoData() {
        self.account = BankViewModel(currentValue: 100500,
                                     expenses: [ExpenseViewModel(value: 1452, operationType: .plus), ExpenseViewModel(value: 1248, operationType: .minus), ExpenseViewModel(value: 3248, operationType: .minus), ExpenseViewModel(value: 74532, operationType: .plus), ExpenseViewModel(value: 29012, operationType: .plus, expenseType: .Other)])
    }
    
    func addExpense(expense: ExpenseViewModel) {
        switch expense.operationType {
        case .plus:
            self.account?.currentValue = (self.account?.currentValue ?? 0) + expense.value
        case .minus:
            self.account?.currentValue = (self.account?.currentValue ?? 0) - expense.value
        }
        switch userStatus {
        case .loggined:
            self.account?.expenses?.insert(expense, at: 0)
            self.addExpenseToFb(expense: expense)
            self.updateCurrentAccountValue()
        default:
            self.account?.expenses?.insert(expense, at: 0)
        }
        self.refreshView()
    }
    
    func updateCurrentAccountValue() {
        guard let account = self.account?.currentValue else { return }
        self.fireBaseManager.updateAccountValue(newValue: account)
    }
    
    private func addExpenseToFb(expense: ExpenseViewModel) {
        self.fireBaseManager.addExpenseToFb(expense: expense)
    }
    
    
    func plusButtonPressed() {
        print("pressed")
        self.view?.showAddExpenseAlert(expense: { expense in
            self.addExpense(expense: expense)
            self.refreshView()
        })
    }
    
    func loadView(view: IBankViewController) {
        self.view = view
    }
    
    func returnCurrentAccountValue() -> String {
            var string = "888"
            if let value = self.account?.currentValue {
                string = String(value)
            }
            return string
    }
    
    func returnCollectionCount() -> Int {
        return account?.expenses?.count ?? 0
    }
    
    func returnCollectionItem(index: Int) -> ExpenseViewModel {
        return account?.expenses?[index] ?? ExpenseViewModel(value: 0, operationType: .plus)
    }
    
    private func refreshView() {
        self.view?.refreshView(currentValue: self.account?.currentValue ?? 0)
    }
    
}
