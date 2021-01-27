//
//  Ex_UICollectionView.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/26.
//  Copyright © 2019 huimin. All rights reserved.
//
import UIKit

public extension HMNameSpace where Base: UICollectionView {
    // MARK: - 类方式注册Cell

    /// 类方式注册Cell
    func registerCellClass<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let identifier = HM.className(cellClass)
        base.register(cellClass, forCellWithReuseIdentifier: identifier)
    }

    // MARK: - Nib方式注册Cell

    /// Nib方式注册Cell
    func registerCellNib<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let identifier = HM.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        base.register(nib, forCellWithReuseIdentifier: identifier)
    }

    // MARK: - Nib方式注册Header

    /// Nib方式注册Header
    func registerHeaderCellNib<T: UICollectionReusableView>(_ cellClass: T.Type) {
        let identifier = HM.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        base.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier)
    }

    // MARK: - 类方式注册Header

    /// 类方式注册Header
    func registerHeaderCellClass<T: UICollectionReusableView>(_ cellClass: T.Type) {
        let identifier = HM.className(cellClass)
        base.register(cellClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier)
    }

    // MARK: - Nib方式注册Footer

    /// Nib方式注册Footer
    func registerFooterCellNib<T: UICollectionReusableView>(_ cellClass: T.Type) {
        let identifier = HM.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        base.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier)
    }

    // MARK: - 类方式注册Footer

    /// 类方式注册Footer
    func registerFooterCellClass<T: UICollectionReusableView>(_ cellClass: T.Type) {
        let identifier = HM.className(cellClass)
        base.register(cellClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier)
    }

    // MARK: - 获取cell, 注册Cell的标识符必须类名

    /// 获取cell, 注册Cell的标识符必须类名
    /// - Parameters:
    ///   - cellClass: Cell类
    ///   - indexPath: 索引
    /// - Returns: Cell
    func dequeueReusableCell<T: UICollectionViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T {
        if let cell = base.dequeueReusableCell(withReuseIdentifier: T.hm_className, for: indexPath) as? T {
            return cell
        } else {
            return T()
        }
    }
}
