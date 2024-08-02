//
//  NewCaseView.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 30/7/24.
//

import SwiftUI

struct NewCaseView: View {
    @State private var caseName: String = ""
    @State private var caseType: CaseType = .singleUser
    @State private var caseNumber: String = ""
    @State private var examinerName: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var notes: String = ""
    
    enum CaseType: String, CaseIterable, Identifiable {
        case singleUser = "Single-User"
        case multiUser = "Multi-User"
        
        var id: String { self.rawValue }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                            
                Section(header: SectionTitleView(title: "New Case Information")) {
                    
                    EntryFieldStackView(titleText: "Case Name", value: $caseName)
            
                    //TODO: Review if Case_type field should be implemented
                    Picker("Case Type", selection: $caseType) {
                        ForEach(CaseType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical, 5)
                    
                    EntryFieldStackView(titleText: "Case Number", value: $caseNumber)
                }
                
                
                Section(header: SectionTitleView(title: "Examiner Information")) {
                    EntryFieldStackView(titleText: "Name", value: $examinerName, optional: true)
                    EntryFieldStackView(titleText: "Phone", value: $phone, optional: true)
                    EntryFieldStackView(titleText: "Email", value: $email, optional: true)
                    TextEditorView(titleText: "Notes", value: $notes)
                }
                
                Button {
                    print($caseName.wrappedValue)
                    print($caseNumber.wrappedValue)
                    print($examinerName.wrappedValue)
                    print($phone.wrappedValue)
                    print($email.wrappedValue)
                    print($notes.wrappedValue)
                } label: {
                    Text("Finish")
                        .frame(width: UIScreen.screenWidth - 75, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.themeBlue, lineWidth: 2)
                        )
                        .foregroundColor(Color.themeBlue)
                        .font(.custom(CFont.graphikMedium.rawValue, size: 15))
                }
                
            }
            .scrollContentBackground(.hidden)
            .navigationBarTitle("New Case")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SectionTitleView: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.custom(CFont.graphikMedium.rawValue, size: 17))
            .foregroundColor(.textColor)
            .frame(width: UIScreen.screenWidth, height: 50)
            .multilineTextAlignment(.center)
            .textCase(.none)
    }
}

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
            .listRowInsets(.init())
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

struct TextEditorView: View {
    
    var titleText: String
    @Binding var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TitleTextFieldView(titleText: titleText, optional: true)

            TextEditor(text: $value)
                .font(.custom(CFont.graphikRegular.rawValue, size: 15))
                .textFieldStyle(RoundedTextFieldStyle())
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(Color.textFieldBackground)
                .cornerRadius(5)
                .frame(height: 150)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    NewCaseView()
}
