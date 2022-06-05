// BankViewDelegate.swift
// Created by Anastasiya Kudasheva on 23.01.2022

import UIKit

class BankViewDelegate: NSObject,
						UICollectionViewDelegate,
						UICollectionViewDataSource,
						UICollectionViewDelegateFlowLayout {
	private let colors: ColorSet
	private let viewCallback: IBankBellsViewCallback

	init(viewCallback: IBankBellsViewCallback, colors: ColorSet) {
		self.colors = colors
		self.viewCallback = viewCallback
		super.init()
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.viewCallback.returnCollectionCount()
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReusibleID.expense.rawValue,
															for: indexPath) as? ExpenseCollectionViewCell
		else { return UICollectionViewCell() }
		let expenseItem = self.viewCallback.returnCollectionItem(index: indexPath.row)

		cell.config(item: expenseItem,
					textColor: self.colors.bankViewColor.itemTextColor)
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
