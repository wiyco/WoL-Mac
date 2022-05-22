//
//  ModelData.swift
//  WoL Mac
//
//  Created by lumiws on 2022/03/24.
//

import Foundation
import Combine

struct ModelData_Path {
    let rootDirectory: String = NSHomeDirectory() + "/Library/com.wiyco.wol-mac"
    let filename: String = "ContentData.json"
}

private let fileManager: DataManager = DataManager()
private let rootDirectory: String = ModelData_Path().rootDirectory
private let filename: String = ModelData_Path().filename

//var allData: [DataType] = load()
final class ModelData: ObservableObject {
    @Published var allData: [DataType] = load()
}

func load<T: Decodable>() -> T {
    let data: Data
    
    guard let fileDefault = Bundle.main.path(forResource: filename, ofType: nil)
    else {
        fatalError("Couldn't find \"\(filename)\" in \"Bundle.main.path\".")
    }
    
    fileManager.copyItem(atPath: fileDefault, toPath: filename)
    
    let file = URL(fileURLWithPath: "\(rootDirectory)/\(filename)", isDirectory: false)
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \"Data\" from \"\(file)\".\n:\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \"\(filename)\" as \"\(T.self)\".\n:\(error)")
    }
}


func save(data: [DataType]) -> Void {
    
    guard let fileDefault = Bundle.main.path(forResource: filename, ofType: nil)
    else {
        fatalError("Couldn't find \"\(filename)\" in \"Bundle.main.path\".")
    }
    
    fileManager.copyItem(atPath: fileDefault, toPath: filename)
    
    let encoder = JSONEncoder()
    
    guard let json = try? encoder.encode(data)
    else {
        fatalError("Couldn't stringify \"\(data)\" as \"\(encoder.self)\".")
    }
    
    let file = URL(fileURLWithPath: "\(rootDirectory)/\(filename)", isDirectory: false)
    
    do {
        try json.write(to: file, options: [.atomic])
    } catch {
        fatalError("Couldn't save \"\(json)\" to \"\(file)\".\n:\(error)")
    }
}
