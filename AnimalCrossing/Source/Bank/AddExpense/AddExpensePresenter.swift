// AddExpensePresenter.swift
// Created by Anastasiya Kudasheva on 26.03.2022

protocol IAddExpensePresenter: IAddExpenseDelegate {
	func didLoad(_ vc: IAddExpenseViewController)
	func cancelButtonTapped()
	func saveButtonTapped(_ textfieldValue: String?)
}

final class AddExpensePresenter {
	private var vc: IAddExpenseViewController?
	private let router: AddExpenseRouter

	private let expensesType: [ExpenseType]
	private let screenType: LoginedScreenType
	private let operationType: OperationType
	private let completion: (ExpenseTransition) -> Void

	private lazy var expenseTransition = ExpenseTransition(
		value: nil,
		currencyType: CurrencyType(self.screenType),
		operationType: self.operationType,
		expenseType: nil
	)

	init(screenType: LoginedScreenType,
		 operationType: OperationType,
		 router: AddExpenseRouter,
		 completion: @escaping (ExpenseTransition) -> Void) {
		self.expensesType = CurrencyType(screenType).expeses(operationType)
		self.screenType = screenType
		self.operationType = operationType
		self.router = router
		self.completion = completion
	}
}

extension AddExpensePresenter: IAddExpensePresenter {
	func didLoad(_ vc: IAddExpenseViewController) {
		self.vc = vc
		self.router.setNavigator(vc)
		self.setupHeader()
		self.vc?.reloadView()
	}

	func cancelButtonTapped() {
		self.router.dismissBack()
	}

	func saveButtonTapped(_ textfieldValue: String?) {
		switch self.validateExpenseTransition(textfieldValue) {
		case .success(let transition):
			self.router.dismissBack {
				self.completion(transition)
			}
		case .failure(let error):
			self.showAlert(error: error)
		}
	}

	func returnCollectionCount() -> Int {
		self.expensesType.count
	}

	func returnCollectionItem(index: Int) -> ExpenseType {
		self.expensesType[index]
	}

	func didSelectItem(at index: Int) {
		self.expenseTransition.expenseType = self.expensesType[index]
	}
}

private extension AddExpensePresenter {
	func validateExpenseTransition(_ textfieldValue: String?)
	-> ACResult<ExpenseTransition, AddExpenseError> {
		if self.expenseTransition.expenseType == nil {
			return .failure(.notSelectExpense)
		}
		if textfieldValue == nil || textfieldValue?.isEmpty ?? false {
			return .failure(.emptyText)
		}
		guard let expenseValue = Int(textfieldValue ?? "")
		else { return .failure(.notInt) }
		self.expenseTransition.value = expenseValue
		return .success(self.expenseTransition)
	}

	func setupHeader() {
		self.vc?.setupHeader("Add" + " " + self.operationType.name)
	}

	func showAlert(error: AddExpenseError) {
		self.vc?.showAlert(title: error.humanfriendlyTitle,
						   message: error.humanfriendlyMessage,
						   completion: nil)
	}
}
