//
//  DataManager.swift
//  WoL Mac
//
//  Created by lumiws on 2022/03/26.
//
//  Referenced: https://qiita.com/am10/items/3b2eb3d9f6c6955455b6
//

import Foundation

struct DataManager {
    private let fileManager: FileManager = FileManager.default
    private let rootDirectory: String = ModelData_Path().rootDirectory
    
    init() {
        createDirectory(atPath: "")
    }
    
    private func convertPath(_ path: String) -> String {
        if path.hasPrefix("/") {
            return rootDirectory + path
        }
        return rootDirectory + "/" + path
    }
    
    private func fileExists(atPath path: String) -> Bool {
        return fileManager.fileExists(atPath: convertPath(path))
    }
    
    func createDirectory(atPath path: String) -> Void {
        if fileExists(atPath: path) {
            return
        }
        do {
            try fileManager.createDirectory(at: URL(fileURLWithPath: convertPath(path), isDirectory: true), withIntermediateDirectories: false, attributes: nil)
        } catch {
            fatalError("Couldn't create \"\(path)\" to \"\(rootDirectory)\".\n:\(error)")
        }
    }
    
    func copyItem(atPath srcPath: String, toPath dstPath: String) -> Void {
        if fileExists(atPath: dstPath) {
            return
        }
        do {
            try fileManager.copyItem(at: URL(fileURLWithPath: srcPath), to: URL(fileURLWithPath: convertPath(dstPath)))
        } catch {
            fatalError("Couldn't copy \"\(srcPath)\" to \"\(convertPath(dstPath))\".\n:\(error)")
        }
    }
}
