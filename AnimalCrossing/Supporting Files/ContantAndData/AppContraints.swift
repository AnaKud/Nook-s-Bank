//
//  AppContraints.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 05.07.2021.
//

import UIKit

struct AppContraints {
    static let iphoneWidth = UIWindow().screen.bounds.width
    static let iphoneHeight = UIWindow().screen.bounds.height
    static let navTitle: CGFloat = iphoneHeight > 800 ? 50 : 30
    static let navAndTabHeight: CGFloat = iphoneHeight > 800 ? 110 : 80

    static let minEdge: CGFloat = 5
    static let midEdge: CGFloat = 10
    static let standartEdge: CGFloat = 20
    static let doubleEdge = standartEdge * 2

    static let standartCornerRadius: CGFloat = 15

	static let defaultBorder: CGFloat = 1

    struct Login {
        static let loginVerticalEdge = navTitle * 4
        static let loginMinVerticalEdge = navTitle * 2
        static let loginHorizontelEdge: CGFloat = 50
        static let cornerRadiusTF: CGFloat = 15
        static let imageLeftViewTF: CGFloat = 10
        static let heightTF: CGFloat = 50
        static let heightButtons = heightTF / 1.5
        static let widthButton = AppContraints.iphoneWidth / 3.3
        static let widthLoginButton = AppContraints.iphoneWidth / 3.3 - 15
    }

    struct Settings {
        static let avatarHeight = iphoneWidth / 4
        static let cornerRadiusTF = AppContraints.standartCornerRadius
		static let widthUserLabel: CGFloat = 60
        static let heightTF: CGFloat = 50
		static let edgesTFToSuperview: CGFloat = 30
		static let widthPadLabel = widthUserLabel * 3
		static let heightButton: CGFloat = 50
		
		static let widthButton: CGFloat = 150
		
		static let widthAccountLabel: CGFloat = 85
    }

    struct CellSizes {
        static let cellBgEdge: CGFloat = 10
        static let cellMaxEdge: CGFloat = 40
        static let widthOffset: CGFloat = -2 * cellBgEdge
        static let cellContentEdge: CGFloat = 20
        static let cellCornerRadius: CGFloat = 15
        static let cellCornerMinRadius: CGFloat = 7
        static let topViewHeight: CGFloat = 44
        static let circleViewSize = 44 - (2 * midEdge)
    }
    struct Bank {
        static let bankAccountViewHeight: CGFloat = 70
        static let plusButtonHeight: CGFloat = 50
        static let collectionCellWidth: CGFloat = (iphoneWidth - 4 * midEdge) / 4.3
        static let collectionCellHeight: CGFloat = collectionCellWidth * 1.54
        static let imageCollectionViewEdge: CGFloat = 10
        static let imageCollectionViewSize: CGFloat = collectionCellWidth - 2 * imageCollectionViewEdge
        static let circleWidth = (collectionCellWidth - (2 * midEdge)) / 2
    }
    struct Turnip {
        static let heightTF: CGFloat = 35
        static let cornerRadius: CGFloat = 5

        static let columnWidth: CGFloat = (AppContraints.iphoneWidth - 2 * AppContraints.midEdge) / 3

        static let weekViewWidth = columnWidth - 30
        static let weekViewHeight = weekViewWidth / 2

        static let priceTFWidth = weekViewWidth - 10
        static let priceTFHeight = weekViewHeight - 10

        static let imageEdge: CGFloat = 5
        static let imageWidthHeight = weekViewHeight - (imageEdge * 2)

        static let monViewOffset = weekViewHeight + AppContraints.midEdge + AppContraints.minEdge

        static let heightButton = heightTF
    }

    struct ProphetPrices {
        static let cornerRadius: CGFloat = 5

        static let columnWidth: CGFloat = (AppContraints.iphoneWidth - 2 * AppContraints.midEdge) / 3

        static let weekViewWidth = columnWidth - 30
        static let weekViewHeight = weekViewWidth / 2

        static let priceTFWidth = weekViewWidth - 10
        static let priceTFHeight = weekViewHeight - 10

        static let imageEdge: CGFloat = 5
        static let imageWidthHeight = weekViewHeight - (imageEdge * 2)

        static let monViewOffset = weekViewHeight + AppContraints.midEdge + AppContraints.midEdge
    }

    struct GraphPrices {
        static let width = AppContraints.iphoneWidth - ( 4 * AppContraints.CellSizes.cellBgEdge)
        static let height = width * 0.9
    }

    struct PinPadLogin {
        static let pinSize: CGFloat = AppContraints.iphoneHeight > 800 ? 30 : 15
        static let pinCorner = pinSize / 2
        static let pinBorder: CGFloat = 2

        static let maxPasswordLength = 6
		static let passCodeWidth: CGFloat = AppContraints.iphoneWidth / 1.5

        static let padSize: CGFloat = AppContraints.iphoneWidth / 4
        static let padCorner = padSize / 2
        static let padBorder: CGFloat = 3
    }
}
