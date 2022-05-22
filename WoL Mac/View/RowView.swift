//
//  RowView.swift
//  WoL Mac
//
//  Created by lumiws on 2022/03/24.
//

import SwiftUI

struct RowView: View {
    var data: DataType
    
    var body: some View {
        Text(data.name).frame(maxWidth: .infinity)
    }
}

struct RowView_Previews: PreviewProvider {
    static var allData = ModelData().allData
    
    static var previews: some View {
        RowView(data: allData[0])
    }
}
