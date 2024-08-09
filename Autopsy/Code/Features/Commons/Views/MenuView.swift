//
//  MenuView.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 9/8/24.
//

import SwiftUI

struct MenuView: View {
    
    var titleText: String? = nil
    var items: [String] = [String]()
    @Binding var selectedItem: String
    
    var fontSize: CGFloat = 15
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let titleText = titleText {
                Text(titleText)
                    .font(.custom(CFont.graphikRegular.rawValue, size: 15))
                    .foregroundColor(.textColor)
            }
            
            Menu {
                ForEach(items, id: \.self) { item in
                    Button(action: {
                        selectedItem = item
                    }, label: {
                        Text(item)
                    })
                }
            } label: {
                HStack {
                    Text(selectedItem)
                        .font(.custom(CFont.graphikRegular.rawValue, size: fontSize))
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.textColor)
                }
                .foregroundStyle(Color.textColor)
                .frame(height: 50)
                .padding(.horizontal)
                .background(Color.textFieldBackground)
                .cornerRadius(5)
            }
            .padding(.vertical, 5)
            
        }
        .frame(maxWidth: .infinity)
        .listRowSeparator(.hidden, edges: .all)
    }
    
}

struct MenuView_Previews: PreviewProvider {
    @State static var selectedItem: String = ""

    static var previews: some View {
        MenuView(titleText: "", selectedItem: $selectedItem)
    }
}
