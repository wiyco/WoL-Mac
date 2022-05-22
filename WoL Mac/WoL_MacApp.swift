//
//  WoL_MacApp.swift
//  WoL Mac
//
//  Created by lumiws on 2022/03/24.
//

import SwiftUI

@main
struct WoL_MacApp: App {
    
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(modelData)
        }
    }
}
