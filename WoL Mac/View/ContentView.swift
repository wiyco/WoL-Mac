//
//  ContentView.swift
//  WoL Mac
//
//  Created by lumiws on 2022/03/24.
//

import SwiftUI

private var cnt = 0

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State var selected: DataType? = nil
    
    var body: some View {
        NavigationView {
            List(modelData.allData, id: \.self, selection: $selected) { item in
                NavigationLink(destination: DetailView(data: item)) {
                    RowView(data: item)
                }
                .frame(height: 42)
                .overlay(
                    Rectangle().foregroundColor(Color.white.opacity(0.3)).frame(height: 1).offset(y: 25)
                )
            }.frame(minWidth: 190)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    HStack  {
                        Button(action: {
                            self.addRow()
                        }) {
                            Label("􀅼", systemImage: "plus")
                        }
                        Divider()
                        Button(action: {
                            self.delRow()
                        }) {
                            Label("􀅽", systemImage: "minus")
                        }
                    }
                }
                ToolbarItem(placement: .navigation) {
                    Button(action: {
                        self.wakeUp()
                    }) {
                        Label("􀆨", systemImage: "power")
                    }
                }
            }
        }.frame(minWidth: 420)
        .navigationTitle("Choose a Device")
    }
    
    private func addRow() -> Void {
        cnt += 1
        let newData = DataType(id: UUID(), name: "myDevice\(cnt)", mac: "", ipAddr: "", bcAddr: "", port: "9")
        modelData.allData.append(newData)
        save(data: modelData.allData)
    }
    
    private func delRow() -> Void {
        if self.selected == nil {
            return
        }
        modelData.allData.removeAll(where: { $0.id == self.selected!.id })
        self.selected = nil
        save(data: modelData.allData)
    }
    
    private func wakeUp() -> Void {
        if self.selected == nil {
            return
        }
        let device = Awake.Device(MAC: self.selected!.mac, BroadcastAddr: self.selected!.bcAddr, Port: UInt16(self.selected!.port) ?? 9)
        _ = Awake.target(device: device)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ModelData())
    }
}
