// BankViewDelegate.swift
// Created by Anastasiya Kudasheva on 23.01.2022

import UIKit

class BankViewDelegate: NSObject,
						UICollectionViewDelegate,
						UICollectionViewDataSource,
						UICollectionViewDelegateFlowLayout {
	private let colors: ColorSet
	private let presenter: IBankPresenter

	init(presenter: IBankPresenter, colors: ColorSet) {
		self.colors = colors
		self.presenter = presenter
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.presenter.returnCollectionCount()
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReusibleID.expense.rawValue,
															for: indexPath) as? ExpenseCollectionViewCell
		else { return UICollectionViewCell() }
		let expenseItem = self.presenter.returnCollectionItem(index: indexPath.row)
		cell.colors = self.colors

		cell.customView = CustomView(colorSet: self.colors)
		cell.config(item: expenseItem)
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

extension BankViewController: UICollectionViewDelegate,
							  UICollectionViewDataSource,
							  UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.presenter.returnCollectionCount()
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReusibleID.expense.rawValue,
															for: indexPath) as? ExpenseCollectionViewCell
		else { return UICollectionViewCell() }
		let expenseItem = self.presenter.returnCollectionItem(index: indexPath.row)
		cell.colors = self.colors
		
		cell.customView = CustomView(colorSet: self.colors)
		cell.config(item: expenseItem)
		collectionView.reloadData()
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
