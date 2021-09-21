////
////  Constraints.swift
//
//import Foundation
//import UIKit
//
//extension UIView {
//    func fillSuperview(padding: UIEdgeInsets) {
//        anchor(top: superview?.topAnchor,
//			   leading: superview?.leadingAnchor,
//			   bottom: superview?.bottomAnchor,
//			   trailing: superview?.trailingAnchor,
//			   padding: padding)
//    }
//
//    func fillSuperview() {
//        fillSuperview(padding: .zero)
//    }
//
//    func anchorSize(to view: UIView) {
//		widthAnchor.constraint(equalTo:
//								view.widthAnchor).isActive = true
//		heightAnchor.constraint(equalTo:
//									view.heightAnchor).isActive = true
//    }
//
//	func anchor(top: NSLayoutYAxisAnchor?,
//				leading: NSLayoutXAxisAnchor?, // swiftlint:disable:this vertical_parameter_alignment
//				bottom: NSLayoutYAxisAnchor?, // swiftlint:disable:this vertical_parameter_alignment
//				trailing: NSLayoutXAxisAnchor?, // swiftlint:disable:this vertical_parameter_alignment
//				padding: UIEdgeInsets = .zero, // swiftlint:disable:this vertical_parameter_alignment
//				size: CGSize = .zero) { // swiftlint:disable:this vertical_parameter_alignment
//        if let top = top {
//            topAnchor.constraint(equalTo: top,
//								 constant: padding.top).isActive = true
//        }
//
//        if let leading = leading {
//            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
//        }
//
//        if let bottom = bottom {
//            bottomAnchor.constraint(equalTo: bottom,
//									constant: -padding.bottom).isActive = true
//        }
//
//        if let trailing = trailing {
//            trailingAnchor.constraint(equalTo: trailing,
//									  constant: -padding.right).isActive = true
//        }
//
//        if size.width != 0 {
//            widthAnchor.constraint(equalToConstant:
//									size.width).isActive = true
//        }
//
//        if size.height != 0 {
//            heightAnchor.constraint(equalToConstant:
//										size.height).isActive = true
//        }
//    }
//
//	func equalCenterX(toView view: UIView) {
//		self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//	}
//
//	func equalCenterY(toView view: UIView) {
//		self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//	}
//
//	func equalCenter(toView view: UIView) {
//		self.equalCenterX(toView: view)
//		self.equalCenterY(toView: view)
//	}
//
//	func updateSize(_ size: CGSize) {
//		self.updateWidth(size.width)
//		self.updateHeight(size.height)
//	}
//
//	func updateWidth(_ width: CGFloat) {
//		self.widthAnchor.constraint(equalToConstant: width).isActive = true
//	}
//
//	func updateHeight(_ height: CGFloat) {
//		self.heightAnchor.constraint(equalToConstant: height).isActive = true
//	}
//}
