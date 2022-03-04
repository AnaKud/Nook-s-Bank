// AvatarCollectionView.swift
// Created by Anastasiya Kudasheva on 11.09.2021

import UIKit

extension RegisterUserView: UIScrollViewDelegate,
							UICollectionViewDelegate,
							UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return AppImage.AvatarIcon.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: CellReusibleID.avatarRegister.rawValue,
			for: indexPath
		) as? AvatarCollectionViewCell else { return UICollectionViewCell() }

		let image = self.getImageName(index: indexPath.row)
		cell.config(with: image.rawValue)
		self.avatarNameHandler = image.rawValue
		return cell
	}

	func getImageName(index: Int) -> AppImage.AvatarIcon {
		let imageNamesArray = AppImage.AvatarIcon.allCases
		return imageNamesArray[index]
	}
}
