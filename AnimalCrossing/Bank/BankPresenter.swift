//
//  BankPresenter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 13.06.2021.
//

import Foundation


protocol IBankPresenter {
    var user: UserLocale? { get set }
    var account: BankViewModel { get set }
    var userStatus: UserStatus? { get set }
    
    func getCurrentUser()
    
    func loadView(view: IBankViewController)
    func getCurrentBankAccountFromFB()
    func plusButtonPressed()
    func returnCurrentAccountValue() -> String
    func returnCollectionCount() -> Int
    func returnCollectionItem(index: Int) -> ExpenseViewModel
}

class BankPresenter {
    var userStatus: UserStatus?
    
    var view: IBankViewController?
    
    var account: BankViewModel = BankViewModel(currentValue: 0, expenses: [ExpenseViewModel(value: 999, operationType: .minus, expenseType: .Other)])
    
    var user: UserLocale?
    
    var fireBaseManager: IBankFireBaseManager
    
    init(fireBaseManager: IBankFireBaseManager) {
        self.fireBaseManager = fireBaseManager
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
        
    }
    
    private func getAccountData() {
        print("add fetch data from fb")
        self.getCurrentBankAccountFromFB()
        self.getCurrentExpensesFromFB()
        
    }
    private func getDemoData() {
        self.account = BankViewModel(currentValue: 100500,
                                     expenses: [ExpenseViewModel(value: 1452, operationType: .plus), ExpenseViewModel(value: 1248, operationType: .minus), ExpenseViewModel(value: 3248, operationType: .minus), ExpenseViewModel(value: 74532, operationType: .plus), ExpenseViewModel(value: 29012, operationType: .plus, expenseType: .Other)])
        self.refreshView(currentValue: self.account.currentValue)
    }
    
    func addExpense(expense: ExpenseViewModel) {
         let expenseForFir = ExpenseFB(fromVM: expense)
        switch expense.operationType {
        case .plus:
            self.account.currentValue = self.account.currentValue + expense.value
            print(self.account.currentValue)
        case .minus:
            self.account.currentValue = self.account.currentValue - expense.value
        }
        switch userStatus {
        case .loggined:
            print(self.account.currentValue)
            self.account.expenses?.insert(expense, at: 0)
            self.addExpenseToFb(expense: expenseForFir)
            self.updateCurrentAccountValue()
        default:
            self.account.expenses?.insert(expense, at: 0)
        }
        self.refreshView(currentValue: self.account.currentValue)
    }
    
    func updateCurrentAccountValue() {
       // guard
            let account = self.account.currentValue //else { return }
        self.fireBaseManager.updateAccountValue(newValue: account)
    }
    
    func getCurrentBankAccountFromFB() {
        self.fireBaseManager.currentBankAccountFromFB { value in
           self.account.currentValue = value
            print("presenter VAlur")
            print(self.account.currentValue)
            self.refreshView(currentValue: self.account.currentValue)
        }
    }
    func getCurrentExpensesFromFB() {
        self.fireBaseManager.currentExpensesFromFB { expensesArray in
            self.account.expenses = expensesArray
            print(self.account.expenses?.count)
            self.refreshView(currentValue: self.account.currentValue)
        }
        
    }
    
    private func addExpenseToFb(expense: ExpenseFB) {
        self.fireBaseManager.addExpenseToFb(expense: expense)
    }
    
    
    func plusButtonPressed() {
        print("pressed")
        self.view?.showAddExpenseAlert(expense: { expense in
            self.addExpense(expense: expense)
        })
    }
    
    func loadView(view: IBankViewController) {
        self.view = view
    }
    
    func returnCurrentAccountValue() -> String {
            var string = "888"
            //if
                let value = self.account.currentValue
            //{
                string = String(value)
            //}
            return string
    }
    
    func returnCollectionCount() -> Int {
        return account.expenses?.count ?? 0
    }
    
    func returnCollectionItem(index: Int) -> ExpenseViewModel {
        return account.expenses?[index] ?? ExpenseViewModel(value: 0, operationType: .plus)
    }
    
    private func refreshView(currentValue: Int?) {
        guard let currentValue = currentValue else { return }
        self.view?.refreshView(currentValue: currentValue)
    }
    
}
