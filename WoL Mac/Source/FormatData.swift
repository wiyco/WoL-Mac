//
//  FormatData.swift
//  WoL Mac
//
//  Created by lumiws on 2022/03/26.
//
//  Referenced: https://qiita.com/shoheiyokoyama/items/5dc67fdc9e06a9dc5728
//

import Foundation

extension String {
    func isMacAddr() -> Bool {
        let pattern: String = #"^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let matches = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
        return matches.count > 0
    }
    
    func isIpv4Addr() -> Bool {
        let pattern: String = #"^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let matches = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
        return matches.count > 0
    }
    
    func isBcAddr() -> Bool {
        let pattern: String = #"^[0-9a-zA-Z\.]*$"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let matches = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
        return matches.count > 0
    }
    
    func isPort() -> Bool {
        if let _: UInt16 = UInt16(self) {
            return true
        }
        return false
    }
}
