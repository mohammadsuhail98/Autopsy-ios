//
//  EntryFieldStackView.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 6/8/24.
//

import SwiftUI

struct EntryFieldStackView: View {
    
    var titleText: String
    @Binding var value: String
    var optional: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TitleTextFieldView(titleText: titleText, optional: optional)
            TextFieldView(titleText: titleText, value: $value)
        }
        .frame(maxWidth: .infinity)
        .listRowSeparator(.hidden, edges: .all)
        .listRowBackground(Color.background)
    }
}

struct TitleTextFieldView: View {
    
    var titleText: String
    var optional: Bool

    var body: some View {
        HStack {
            Text(titleText)
                .font(.custom(CFont.graphikRegular.rawValue, size: 15))
                .foregroundColor(.textColor)
            
            if optional {
                Text("Optional")
                    .font(.custom(CFont.graphikLight.rawValue, size: 13))
                    .foregroundColor(.gray)
            }
        }
    }
}


struct TextFieldView: View {
    
    var titleText: String
    @Binding var value: String
    
    var body: some View {
        TextField(titleText, text: $value)
            .textFieldStyle(RoundedTextFieldStyle())
            .keyboardType(keyboardType(for: titleText))
            .font(.custom(CFont.graphikRegular.rawValue, size: 15))
            .previewLayout(.sizeThatFits)
            .listRowBackground(Color.clear)
            .frame(height: 50)
            .listRowSeparator(.hidden)
            .padding(.vertical, 5)
    }
    
    private func keyboardType(for title: String) -> UIKeyboardType {
        switch title {
        case "Phone":
            return .phonePad
        case "Email":
            return .emailAddress
        default:
            return .default
        }
    }
}

struct EntryFieldStackView_Previews: PreviewProvider {
    @State static var previewValue = ""
    
    static var previews: some View {
        EntryFieldStackView(titleText: "Example Title", value: $previewValue)
    }
}
