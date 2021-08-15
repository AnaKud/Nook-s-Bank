//
//  FireBaseManager.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import Foundation
import Firebase

protocol IPresenterForFireBaseManager{
    func presentError(error: FailureCases)
}

protocol ILoginFireBaseManager {
    var loginPresenter: ILoginPresenter? { get set }
    func login(withEmail email: String, withPassword password: String)
    func register(withUserName name: String, withEmail email: String, withPassword password: String)
	func logout()
}

protocol IBankFireBaseManager {
    var bankPresenter: IBankPresenter? { get set }
    func addExpenseToFb(expense: ExpenseFB)
    func getUser() -> UserLocale?
    func updateAccountValue(newValue: Int)
    func currentBankAccountFromFB(completion: @escaping (Int) -> ())
    func currentExpensesFromFB(completion: @escaping ([ExpenseViewModel]) -> ())
}

protocol ITurnipFireBaseManager {
    func addExpenseToFb(expense: ExpenseFB)
}

protocol IUserSettingsFireBaseManager {
    
}

class FireBaseManager {
    static let shared = FireBaseManager()
    
    var loginPresenter: ILoginPresenter?
    var bankPresenter: IBankPresenter?
    let refUser = Database.database().reference(withPath: "users")
    var refBankAccount: DatabaseReference?
    var refExpenses: DatabaseReference?
}

extension FireBaseManager: ILoginFireBaseManager {
    func auth() {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user != nil {
                self?.loginPresenter?.openWithLogin()
            }
        }
    }
    
    func login(withEmail email: String, withPassword password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] (user, error) in
            if error != nil {
                self?.loginPresenter?.showWarningLabel(withWarningText: LoginWarnings.unexpectedError.rawValue)
                return
            }
            if user != nil {
                self?.loginPresenter?.openWithLogin()
            } else {
                self?.loginPresenter?.showWarningLabel(withWarningText: LoginWarnings.notRegister.rawValue)
            }
        })
    }
    
    func register(withUserName name: String, withEmail email: String, withPassword password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            guard error == nil,
                  let user = user
            else {
                self?.loginPresenter?.showWarningLabel(withWarningText: error!.localizedDescription)
                print(error!.localizedDescription)
                return
            }
            let userRef = self?.refUser.child(user.user.uid)
            userRef?.setValue(["email": user.user.email])
            userRef?.setValue(["userName": name])
            userRef?.child("currentAcount").setValue(["currentValue": 0])
            self?.loginPresenter?.openForRegister()
        }
    }
	
	func logout() {
		do {
			try Auth.auth().signOut()
		} catch  {
			print(error.localizedDescription)
		}
	}
}

extension FireBaseManager: IBankFireBaseManager {
    func getUser() -> UserLocale? {
        guard let currentUser = Auth.auth().currentUser,
              let user = UserLocale(user: currentUser)
        else { return nil }
        self.refBankAccount = self.setupRefBankAccount(forUser: currentUser)
        self.refExpenses = self.setupRefExpense()
        return user
    }
    
    func currentBankAccountFromFB(completion: @escaping (Int) -> ()) {
        self.refBankAccount?.observe(.value, with: { (snapshot) in
            guard let bankAccount = snapshot.childSnapshot(forPath: "currentValue").value as? Int else { return }
            completion(bankAccount)
        })
    }
    
    func currentExpensesFromFB(completion: @escaping ([ExpenseViewModel]) -> ()) {
        self.refExpenses?.observe(.value, with: { (snapshot) in
            var expenses = [ExpenseViewModel]()
            for item in snapshot.children {
                guard
                    let item = item as? DataSnapshot,
                    let expense = ExpenseViewModel(snapshot: item)
                else { return }
                expenses.append(expense)
            }
            completion(expenses)
        })
    }
    
    func updateAccountValue(newValue: Int) {
        self.refBankAccount?.updateChildValues(["currentValue": newValue])
    }
    
    func addExpenseToFb(expense: ExpenseFB) {
        let refOnCurrentFb = self.refExpenses?.child(expense.uid)
        refOnCurrentFb?.setValue(expense.converToDictionary())
    }

    func setupRefBankAccount(forUser user: User) -> DatabaseReference? {
        return Database.database().reference(withPath: "users").child(String(user.uid)).child("currentAcount")
    }
     
    func setupRefExpense() -> DatabaseReference? {
        guard let bankRef = self.refBankAccount else { return nil }
        let expenseRef = bankRef.child("expenses")
        return expenseRef
    }
}

extension FireBaseManager: ITurnipFireBaseManager {
    
}


extension FireBaseManager: IPresenterForFireBaseManager {
    func presentError(error: FailureCases) {
        self.loginPresenter?.presentError(error: error)
    }
}

extension FireBaseManager: IUserSettingsFireBaseManager {
    
    
}
