//
//  HMFile.swift
//  HMCoreKit
//
//  Created by huimin on 2020/3/23.
//  Copyright © 2020 huimin. All rights reserved.
//

import Foundation

/// 文件管理
public final class HMFile {
    /// 单例对象
    public static var shared = HMFile()

    /// 文件管理对象
    private let fileManager = FileManager.default

    /// 沙盒根目录
    public var rootPath: String {
        return NSHomeDirectory()
    }

    /*
     保存应用程序的重要数据文件和用户数据文件等(例如从网上下载的图片或音乐文件);
     该文件夹在应用程序更新时会自动备份，在连接iTunes时也可以自动同步备份其中的数据
     */
    /// 沙盒document 路径
    public var documentPath: String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }

    /// 沙盒document URL
    public var documentUrl: URL? {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    }

    /// 沙盒library 路径
    public var libraryPath: String? {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
    }

    /// 沙盒library Url
    public var libraryUrl: URL? {
        return fileManager.urls(for: .libraryDirectory, in: .userDomainMask).first
    }

    /// 沙盒临时文件路径
    public var tempPath: String {
        return NSTemporaryDirectory()
    }

    // MARK: - 创建文件夹,已存在不会创建

    /// 创建文件夹，已存在不会创建
    /// - Parameters:
    ///   - path: 文件夹路径(全路径)
    public func createFolder(path: String?) {
        guard let path = path else {
            return
        }

        do {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
        } catch {
            HM.logger(content: "文件将创建失败: \(error.localizedDescription)")
        }
    }

    // MARK: - 获取文件夹大小(单位: 字节) 不存在将返回0

    /// 获取文件夹大小(单位: 字节) 不存在将返回0
    /// - Parameter path: 文件夹路径(全路径)
    public func getSizeFolder(path: String?) -> Int64 {
        guard let path = path else {
            return 0
        }

        do {
            let contents = try fileManager.contentsOfDirectory(atPath: path)
            var folderSize: Int64 = 0

            for content in contents {
                do {
                    let fullPath = path + "/" + content
                    let fileAttributes = try fileManager.attributesOfFileSystem(forPath: fullPath)
                    folderSize += fileAttributes[FileAttributeKey.size] as? Int64 ?? 0

                } catch {
                    continue
                }
            }
            return folderSize
        } catch {
            return 0
        }
    }

    // MARK: - 删除文件: URL路径

    /// 删除文件: URL路径
    /// - Parameters:
    ///   - url: 文件路径
    ///   - completion: 操作结果回调
    public func deleteItem(url: URL, completion: ((Error?) -> Void)? = nil) {
        do {
            try fileManager.removeItem(at: url)
            completion?(nil)

        } catch {
            HM.logger(content: "item删除失败: \(error.localizedDescription)")
            completion?(error)
        }
    }

    // MARK: - 删除文件: String路径

    /// 删除文件: String路径
    /// - Parameters:
    ///   - path: 文件路径
    ///   - completion: 操作结果回调
    public func deleteItem(path: String, completion: ((Error?) -> Void)? = nil) {
        do {
            try fileManager.removeItem(atPath: path)
            completion?(nil)
        } catch {
            HM.logger(content: "item删除失败: \(error.localizedDescription)")
            completion?(error)
        }
    }

    // MARK: - 判断文件时候存在

    /// 判断文件时候存在
    /// - Parameter filePath: 文件路径
    /// - Returns: 文件是否存在bool
    public func fileExist(filePath: String) -> Bool {
        return fileManager.fileExists(atPath: filePath)
    }

    // MARK: - 删除文件夹所有内容

    /// 删除文件夹所有内容
    /// - Parameter folder: 文件夹
    public func removeAll(folder: String) {
        let newFolder = folder
        do {
            // 先删除文件夹
            try fileManager.removeItem(atPath: folder)
            // 然后创建同名的文件夹
            try fileManager.createDirectory(atPath: newFolder, withIntermediateDirectories: true, attributes: nil)
        } catch {
            HM.logger(content: "删除文件夹所有内容失败: \(error.localizedDescription)")
        }
    }

    // MARK: - 获取文件创建时间

    /// 获取文件创建时间
    /// - Parameter path: 文件路径
    /// - Returns: 时间
    public func fileCreateDate(path: String) -> Date? {
        do {
            let attrs = try fileManager.attributesOfItem(atPath: path) as NSDictionary
            return attrs.fileCreationDate()
        } catch {
            HM.logger(content: "获取文件创建时间失败: \(error.localizedDescription)")
            return nil
        }
    }

    // MARK: - 获取文件大小

    /// 获取文件大小
    /// - Parameter path: 文件路径
    /// - Returns: 大小（byte）
    public func getFileSize(path: String) -> UInt64 {
        do {
            let attrs = try fileManager.attributesOfItem(atPath: path) as NSDictionary
            return attrs.fileSize()
        } catch {
            HM.logger(content: "获取文件大小: \(error.localizedDescription)")
            return 0
        }
    }

    // MARK: - 重命名文件

    /// 重命名文件
    /// - Parameters:
    ///   - oldPath: 旧名称
    ///   - newPath: 新名称
    /// - Returns: 是否成功
    @discardableResult
    public func renameFile(oldPath: String, newPath: String) -> Bool {
        // 名字一样不处理
        guard oldPath != newPath else { return false }
        do {
            try fileManager.moveItem(atPath: oldPath, toPath: newPath)
            return true
        } catch {
            HM.logger(content: "文件重命名失败: \(error.localizedDescription)")
            return false
        }
    }

    // MARK: - 复制文件

    /// 复制文件
    /// - Parameters:
    ///   - oldPath: 旧文件路径
    ///   - newPath: 新文件路径
    ///   - completionHandler: 操作结果回调
    public func copyFile(oldPath: String,
                         newPath: String,
                         completionHandler: ((_ success: Bool, _ error: Error?) -> Void)? = nil) {
        do {
            try fileManager.copyItem(atPath: oldPath, toPath: newPath)
        } catch {
            HM.logger(content: "复制文件失败: \(error.localizedDescription)")
        }
    }

    // MARK: - 移动文件

    public func moveFile(oldPath: String, newPath: String) {
        do {
            try fileManager.moveItem(atPath: oldPath, toPath: newPath)
        } catch {
            HM.logger(content: "移动文件失败: \(error.localizedDescription)")
        }
    }
}

public extension String {
    /// 生成在沙盒Document文件夹中的路径
    var hm_inDocumentPath: String? {
        if let doc = HMFile.shared.documentPath {
            return doc + "/" + self
        }
        return nil
    }

    /// 生成在沙盒Document文件夹中的URL
    var hm_inDocumentUrl: URL? {
        if let doc = HMFile.shared.documentUrl {
            return doc.appendingPathComponent(self)
        }
        return nil
    }

    /// 生成在沙盒根目录文件夹中的路径
    var hm_inRootPath: String {
        return HMFile.shared.rootPath + "/" + self
    }

    /// 生成在沙盒临时文件夹中的路径
    var hm_inTempPath: String {
        return HMFile.shared.tempPath + "/" + self
    }
}
