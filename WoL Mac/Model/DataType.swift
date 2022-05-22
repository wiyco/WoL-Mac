//
//  DataType.swift
//  WoL Mac
//
//  Created by lumiws on 2022/03/24.
//

import Foundation

struct DataType: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var mac: String
    var ipAddr: String
    var bcAddr: String
    var port: String
}
