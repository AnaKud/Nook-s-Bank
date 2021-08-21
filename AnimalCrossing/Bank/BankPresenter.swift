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
    var screenType: ScreenTypes? { get set }

    func getCurrentUser()

    func loadView(view: IBankViewController)
    func plusButtonTapped()
    func returnCurrentAccountValue() -> String
    func returnCollectionCount() -> Int
    func returnCollectionItem(index: Int) -> ExpenseViewModel
}

class BankPresenter {
    var screenType: ScreenTypes?

    var view: IBankViewController?

    var account = BankViewModel(currentValue: 0, expenses: [ExpenseViewModel(value: 999, operationType: .minus, expenseType: .other)])

    var user: UserLocale?

    var fireBaseManager: IBankFireBaseManager
    var router: IBankRouter

    init(fireBaseManager: IBankFireBaseManager, router: IBankRouter) {
        self.fireBaseManager = fireBaseManager
        self.router = router
    }
}

extension BankPresenter: IBankPresenter {
    func getCurrentUser() {
        switch screenType {
        case .loggined:
            self.user = self.fireBaseManager.getUser()
            print(self.user?.email)
            self.getAccountData()
        default:
            self.user = nil
            self.getDemoData()
        }
    }

    private func getAccountData() {
        self.getCurrentBankAccountFromFB()
        self.getCurrentExpensesFromFB()
    }

    private func getDemoData() {
        self.account = DemoBankData.account
        self.view?.interfaceWithData()
        self.refreshView()
    }

    func addExpense(expense: ExpenseViewModel) {
        var supportingAccountData = self.account.currentValue
        let expenseForFir = ExpenseFB(fromVM: expense)
        switch expense.operationType {
        case .plus:
            self.account.currentValue += expense.value
            print(self.account.currentValue)
        case .minus:
            supportingAccountData -= expense.value
            if supportingAccountData > 0 {
                self.account.currentValue -= expense.value
            } else {
                return
            }
        }
        switch screenType {
        case .loggined:
            print(self.account.currentValue)
            self.account.expenses?.insert(expense, at: 0)
            self.addExpenseToFb(expense: expenseForFir)
            self.updateCurrentAccountValue()
        default:
            self.account.expenses?.insert(expense, at: 0)
        }
        self.refreshView()
    }

    func updateCurrentAccountValue() {
        let account = self.account.currentValue
        self.fireBaseManager.updateAccountValue(newValue: account)
    }

    func getCurrentBankAccountFromFB() {
        self.fireBaseManager.currentBankAccountFromFB { value in
            self.account.currentValue = value
            print(value)
            self.view?.interfaceWithData()
            self.refreshView()
        }
    }

    private func getCurrentExpensesFromFB() {
        self.fireBaseManager.currentExpensesFromFB { [weak self] expensesArray in
            self?.account.expenses = self?.sortExpenses(expensesInput: expensesArray)
            self?.view?.interfaceWithData()
            self?.refreshView()
        }
    }

    private func addExpenseToFb(expense: ExpenseFB) {
        self.fireBaseManager.addExpenseToFb(expense: expense)
    }

    func plusButtonTapped() {
        print("pressed")
        self.view?.showAddExpenseAlert(expense: { expense in
            self.addExpense(expense: expense)
        })
    }

    func loadView(view: IBankViewController) {
        self.view = view
    }

    func returnCurrentAccountValue() -> String {
        return String(self.account.currentValue)
    }

    func returnCollectionCount() -> Int {
        return account.expenses?.count ?? 0
    }

    func returnCollectionItem(index: Int) -> ExpenseViewModel {
        return account.expenses?[index] ?? ExpenseViewModel(value: 0, operationType: .plus)
    }

    private func refreshView() {
        let displayedValue = self.returnCurrentAccountValue()
        self.view?.refreshView(currentValue: displayedValue)
    }

    private func sortExpenses(expensesInput: [ExpenseViewModel]?) -> [ExpenseViewModel]? {
        var result = [ExpenseViewModel]()
        result = expensesInput?.sorted(by: { $0.date?.compare($1.date ?? Date()) == .orderedDescending }) ?? [ExpenseViewModel]()
        return result
    }
}
