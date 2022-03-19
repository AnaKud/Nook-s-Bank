// BankViewDelegate.swift
// Created by Anastasiya Kudasheva on 23.01.2022

import UIKit

class BankViewDelegate: NSObject,
						UICollectionViewDelegate,
						UICollectionViewDataSource,
						UICollectionViewDelegateFlowLayout {
	private let colors: ColorSet
	private let interactor: IBankInteractor

	init(interactor: IBankInteractor, colors: ColorSet) {
		self.colors = colors
		self.interactor = interactor
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.interactor.returnCollectionCount()
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReusibleID.expense.rawValue,
															for: indexPath) as? ExpenseCollectionViewCell
		else { return UICollectionViewCell() }
		let expenseItem = self.interactor.returnCollectionItem(index: indexPath.row)

		cell.config(item: expenseItem,
					textColor: .black) //self.colors.bankViewColor.itemTextColor)
		return cell
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		return CGSize(width: AppContraints.Bank.collectionCellWidth,
					  height: AppContraints.Bank.collectionCellHeight)
	}
}

//extension BankViewController: UICollectionViewDelegate,
//							  UICollectionViewDataSource,
//							  UICollectionViewDelegateFlowLayout {
//	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		return self.presenter.returnCollectionCount()
//	}
//	
//	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReusibleID.expense.rawValue,
//															for: indexPath) as? ExpenseCollectionViewCell
//		else { return UICollectionViewCell() }
//		let expenseItem = self.presenter.returnCollectionItem(index: indexPath.row)
//		cell.colors = self.colors
//		
//		cell.customView = CustomView(colorSet: self.colors)
//		cell.config(item: expenseItem)
//		collectionView.reloadData()
//		return cell
//	}
//	
//	func collectionView(
//		_ collectionView: UICollectionView,
//		layout collectionViewLayout: UICollectionViewLayout,
//		sizeForItemAt indexPath: IndexPath
//	) -> CGSize {
//		return CGSize(width: AppContraints.Bank.collectionCellWidth,
//					  height: AppContraints.Bank.collectionCellHeight)
//	}
//}
