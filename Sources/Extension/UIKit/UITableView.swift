//
//  Ex_UITableView.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

public extension HMNameSpace where Base: UITableView {
    // MARK: - TableView是否为空

    /// TableView是否为空
    var isEmpty: Bool {
        return lastSectionWithRows == nil
    }

    // MARK: - TableView指定分区是否为空

    /// TableView指定分区是否为空
    func isEmpty(section: Int) -> Bool {
        return base.numberOfRows(inSection: section) == 0
    }

    // MARK: - TableView最后分区索引

    /// TableView最后分区索引
    var lastSection: Int? {
        if base.numberOfSections > 0 {
            return base.numberOfSections - 1
        }
        return nil
    }

    // MARK: - TableView最后一个不为零的section索引

    /// TableView最后一个不为零的section索引
    var lastSectionWithRows: Int? {
        if base.numberOfSections == 0 { return nil }
        var section = base.numberOfSections - 1
        if section < 0 { return nil }
        while section >= 0 {
            if base.numberOfRows(inSection: section) != 0 { return section }
            section -= 1
        }
        return nil
    }

    // MARK: - TableView第一个不为零的section索引

    /// TableView第一个不为零的section索引
    var firstSectionWithRows: Int? {
        if base.numberOfSections == 0 { return nil }
        var section = 0
        if section > base.numberOfSections - 1 { return nil }
        while section <= (base.numberOfSections - 1) {
            if base.numberOfRows(inSection: section) != 0 { return section }
            section += 1
        }
        return nil
    }

    // MARK: - 加载分区数据

    /// 加载分区数据
    func reload(section: Int, with: UITableView.RowAnimation) {
        if let last = lastSection, last >= section {
            base.reloadSections(IndexSet(integer: section), with: with)
        }
    }

    // MARK: - 加载分区数据

    /// 加载分区数据
    func reload(sections: Int..., with: UITableView.RowAnimation) {
        base.reloadSections(IndexSet(sections), with: with)
    }

    // MARK: - 加载某一行数据

    /// 加载某一行数据
    func reload(row: IndexPath..., with: UITableView.RowAnimation) {
        base.reloadRows(at: row, with: with)
    }
}

// MARK: - Cell注册

public extension HMNameSpace where Base: UITableView {
    // MARK: - 类方式注册Cell

    /// 类方式注册Cell
    func registerCellClass<T: UITableViewCell>(_ cellClass: T.Type) {
        let identifier = HM.className(cellClass)
        base.register(cellClass, forCellReuseIdentifier: identifier)
    }

    // MARK: - Nib方式注册Cell

    /// Nib方式注册Cell
    func registerCellNib<T: UITableViewCell>(_ cellClass: T.Type) {
        let identifier = HM.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        base.register(nib, forCellReuseIdentifier: identifier)
    }

    // MARK: - 类方式注册表头、表尾

    /// 类方式注册表头、表尾
    func registerHeaderFooterViewClass<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) {
        let identifier = HM.className(viewClass)
        base.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }

    // MARK: - Nib方式注册表头、表尾

    /// Nib方式注册表头、表尾
    func registerHeaderFooterViewNib<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) {
        let identifier = HM.className(viewClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        base.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }

    // MARK: - 获取重用cell, 注册的cell的标识符必须是类名

    /// 获取重用cell, 注册的cell的标识符必须是类名
    /// - Parameters:
    ///   - cellClass: cell类
    ///   - indexPath: 索引
    /// - Returns: Cell
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T {
        if let cell = base.dequeueReusableCell(withIdentifier: T.hm_className, for: indexPath) as? T {
            return cell
        } else {
            return T()
        }
    }
}
