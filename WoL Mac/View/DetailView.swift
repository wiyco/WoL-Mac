//
//  DetailView.swift
//  WoL Mac
//
//  Created by lumiws on 2022/03/24.
//

import SwiftUI

private let gradientView: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)

struct DetailView: View {
    @EnvironmentObject var modelData: ModelData
    var data: DataType
    @State private var name: String
    @State private var mac: String
    @State private var ip: String
    @State private var bc: String
    @State private var port: String
    
    init(data: DataType) {
        self.data = data
        _name = State(initialValue: data.name)
        _mac = State(initialValue: data.mac)
        _ip = State(initialValue: data.ipAddr)
        _bc = State(initialValue: data.bcAddr)
        _port = State(initialValue: data.port)
    }
    
    var body: some View {
        VStack {
            TextField("Name (myDevice)", text: $name).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.top)
            TextField("MAC Address (FF:FF:FF:FF:FF:FF)", text: $mac).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.top)
            TextField("IP Address (192.168.1.11)", text: $ip).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.top)
            TextField("Broadcast Address (192.168.1.255)", text: $bc).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.top)
            TextField("Port (Default: 9)", text: $port).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.top)
            Button(action: {
                self.saveVal()
            }) {
                Text("Save").frame(width: 60)
            }
            .foregroundColor(Color.white)
            .background(gradientView)
            .cornerRadius(60)
            .padding()
        }
        .navigationTitle(Text(data.name))
        .padding()
    }
    
    private func saveVal() -> Void {
        if !mac.isMacAddr() || !ip.isIpv4Addr() || !bc.isBcAddr() || !port.isPort() {
            return
        }
        guard let idx = modelData.allData.firstIndex(where: { $0.id == self.data.id })
        else {
            fatalError("Couldn't get \"Index\" of \"\(self.data.id)\" from \"modelData.allData[]\".")
        }
        modelData.allData[idx].name = name
        modelData.allData[idx].mac = mac
        modelData.allData[idx].ipAddr = ip
        modelData.allData[idx].bcAddr = bc
        modelData.allData[idx].port = port
        save(data: modelData.allData)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        DetailView(data: ModelData().allData[0]).environmentObject(modelData)
    }
}
