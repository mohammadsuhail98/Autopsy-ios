//
//  DataSourceContentScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 22/8/24.
//

import SwiftUI

struct DSContent: Identifiable {
    let id = UUID()
    let name: String
    let icon: String

}

struct DSContentScreen: View {
    
    @State private var items = [
        DSContent(name: "$Orphan files", icon: "folder"),
        DSContent(name: "$Orphan", icon: "file"),
        DSContent(name: "Saga", icon: "document"),
        DSContent(name: "hd_nikon.jpg", icon: "image"),
    ]
    
    var body: some View {
        ZStack {
            List {
                ForEach(items) { item in
                    DSContentHStackLabel(item: item)
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .customBackground()
        }
        .navigationTitle("Item Name")
        .navigationBarTitleDisplayMode(.inline)
        .customBackground()
    }
}

struct DSContentHStackLabel: View {
    
    var item: DSContent
    
    var body: some View {
        
        Color.white
            .frame(height: 50)
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
            .overlay {
                VStack {
                    HStack() {
                        Image(item.icon)
                            .foregroundColor(.textColor)
                        Text(item.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom(CFont.graphikRegular.rawValue, size: 15))
                            .foregroundColor(.textColor)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.textColor)
                    }
                    .padding(.horizontal, 15)
                }
            }
    }
}

#Preview {
    DSContentScreen()
}
