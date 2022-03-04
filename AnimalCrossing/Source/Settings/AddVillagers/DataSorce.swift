// AvatarCollectionView.swift
// Created by Anastasiya Kudasheva on 11.09.2021

import UIKit

extension GeneralUserInfoView: UIScrollViewDelegate,
							   UICollectionViewDelegate,
							   UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return AppImage.AvatarIcon.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: CellReusibleID.avatarRegister.rawValue,
			for: indexPath)
				as? AvatarCollectionViewCell
		else { return UICollectionViewCell() }

		let image = self.getImageName(index: indexPath.row)
		cell.config(with: image.rawValue)
		return cell
	}

	func getImageName(index: Int) -> AppImage.AvatarIcon {
		var imageNamesArray = AppImage.AvatarIcon.allCases
		if let avatarName = self.userSettings?.avatar,
		   let avatar = AppImage.AvatarIcon(rawValue: avatarName) {
			if let firstIndex = imageNamesArray.firstIndex(of: avatar) {
				print("int")
				let countAfterSelectedAvatar = imageNamesArray.count - firstIndex
				let subLastArray = imageNamesArray.dropLast(countAfterSelectedAvatar)
				let countBeforeSelectedAvatar = imageNamesArray.count - countAfterSelectedAvatar
				let subFirstArray = imageNamesArray.dropFirst(countBeforeSelectedAvatar)
				imageNamesArray.removeAll()
				imageNamesArray.append(contentsOf: subFirstArray)
				imageNamesArray.append(contentsOf: subLastArray)

				print(imageNamesArray.count)
			}
		}
		return imageNamesArray[index]
	}
}
