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
}

protocol IBankFireBaseManager {
    var bankPresenter: IBankPresenter? { get set }
    
    func addExpenseToFb(expense: ExpenseViewModel)
    func getUser() -> UserLocale?
    func updateAccountValue(newValue: Int)
    
}

class FireBaseManager {
    
    var loginPresenter: ILoginPresenter?
    var bankPresenter: IBankPresenter?
    
    
    let refUser = Database.database().reference(withPath: "users")
    var refBankAccount: DatabaseReference?
    var refExpenses: DatabaseReference?
    

}

extension FireBaseManager: ILoginFireBaseManager{
    
    
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
    
   
    
    
    
}


extension FireBaseManager: IBankFireBaseManager {
    
    
    func getUser() -> UserLocale? {
        guard let currentUser = Auth.auth().currentUser,
              let user = UserLocale(user: currentUser)
        else { return nil }
        self.refBankAccount = self.setupRefBankAccount()
        self.refExpenses = self.setupRefExpense()
        return user
    }
    
    func currentBankAccountFromFB() {
        self.refBankAccount?.observe(.value, with: { [ weak self ] (snapshot) in
           // var account: BankViewModel?
           // guard let item = BankViewModel(s)
                 
            
        })
    }
    
    func updateAccountValue(newValue: Int) {
        self.refBankAccount?.updateChildValues(["currentValue": newValue])
    }
    
    func addExpenseToFb(expense: ExpenseViewModel) {
        let refOnCurrentFb = self.refExpenses?.child(expense.uid)
        refOnCurrentFb?.setValue(expense.converToDictionary())
        
    }
    

    func setupRefBankAccount() -> DatabaseReference? {
        guard let user = self.bankPresenter?.user else { return nil }
        return self.refUser.child(String(user.uid)).child("currentAcount")
    }
     
    func setupRefExpense() -> DatabaseReference? {
        let bankRef = self.setupRefBankAccount()
        let expenseRef = bankRef?.child("expenses")
        return expenseRef
    }
 
}

extension FireBaseManager: IPresenterForFireBaseManager {
    
    func presentError(error: FailureCases) {
        self.loginPresenter?.presentError(error: error)
    }

}
