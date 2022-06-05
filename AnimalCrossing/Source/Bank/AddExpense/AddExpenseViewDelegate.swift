// AddExpenseViewDelegate.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

protocol IAddExpenseDelegate: AnyObject {
	func returnCollectionCount() -> Int
	func returnCollectionItem(index: Int) -> ExpenseType
	func didSelectItem(at index: Int)
}

final class AddExpenseViewDelegate: NSObject,
									UICollectionViewDelegate,
									UICollectionViewDataSource ,
									UICollectionViewDelegateFlowLayout {
	private let callback: IAddExpenseDelegate

	init(callback: IAddExpenseDelegate) {
		self.callback = callback
		super.init()
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.callback.returnCollectionCount()
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReusibleID.addExpense.rawValue,
															for: indexPath) as? AddExpenseCollectionViewCell
		else { return UICollectionViewCell() }
		let item = self.callback.returnCollectionItem(index: indexPath.row)
		cell.config(item, bankViewColor: ColorSet.BankViewColor(.logined(.bells)))
		return cell
	}

	func collectionView(_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: AppContraints.AddExpense.collectionCellWidth,
					  height: AppContraints.AddExpense.collectionCellHeight)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.callback.didSelectItem(at: indexPath.row)
	}
}
