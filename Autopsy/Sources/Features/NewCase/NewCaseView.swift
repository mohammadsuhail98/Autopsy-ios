//
//  NewCaseView.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 30/7/24.
//

import SwiftUI
import PopupView

struct NewCaseView: View {
    @EnvironmentObject private var router: Router
    
    @State private var caseName: String = ""
    @State private var caseType: CaseType = .singleUser
    @State private var caseNumber: String = ""
    @State private var examinerName: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var notes: String = ""
    @State private var showingResultPopup = false
    
    enum CaseType: String, CaseIterable, Identifiable {
        case singleUser = "Single-User"
        case multiUser = "Multi-User"
        
        var id: String { self.rawValue }
    }
    
    var body: some View {
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
                .listRowBackground(Color.background)
                
                EntryFieldStackView(titleText: "Case Number", value: $caseNumber)
            }
            
            
            Section(header: SectionTitleView(title: "Examiner Information")) {
                EntryFieldStackView(titleText: "Name", value: $examinerName, optional: true)
                EntryFieldStackView(titleText: "Phone", value: $phone, optional: true)
                EntryFieldStackView(titleText: "Email", value: $email, optional: true)
                TextEditorView(titleText: "Notes", value: $notes)
            }
            
            Button {
                showingResultPopup = true
            } label: {
                BorderedBtnLabelView(title: "Finish")
            }
            .listRowBackground(Color.background)
            
        }
        .scrollContentBackground(.hidden)
        .customBackground()
        .navigationBarTitle("New Case", displayMode: .inline)
        .navigationBarModifier(backgroundColor: .systemBackground, foregroundColor: .black, tintColor: .black, withSeparator: false)
        .popup(isPresented: $showingResultPopup) {
            ResultPopupView { tag in
                if tag == 0 {
                    router.caseCreationPath.append(.addDataSourceType)
                } else {
                    router.selectedScenario = .caseHome
                }
            }
        } customize: {
            $0
                .isOpaque(true)
                .type(.floater(verticalPadding: 20, horizontalPadding: 20, useSafeAreaInset: true))
                .position(.center)
                .animation(.spring())
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.5))
        }
    }
}


struct SectionTitleView: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.custom(CFont.graphikMedium.rawValue, size: 17))
            .foregroundColor(.textColor)
            .frame(width: UIScreen.screenWidth - 75, height: 50)
            .textCase(.none)
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
        .listRowBackground(Color.background)
        .padding(.vertical, 5)
    }
}

struct ResultPopupView: View {
    
    var onFinished: (Int) -> Void
    
    var body: some View {
        VStack() {
            TitleWithIconView(icon: "create_case_success", title: "Case Name", subtitle: "Case has been added to database Successfully!")
                .padding(.horizontal, 40)
            
            VStack(spacing: 10) {
                
                Button {
                    onFinished(0)
                } label: {
                    Text("Add New Data Source")
                        .font(Font.custom(CFont.graphikSemibold.rawValue, size: 13))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.themeBlue)
                        .foregroundColor(Color.white)
                        .cornerRadius(5)
                        .shadow(color: .shadow, radius: 2, x: 1, y: 1)
                }
                
                Button {
                    onFinished(1)
                } label: {
                    Text("Finish")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.themeBlue, lineWidth: 2)
                        )
                        .foregroundColor(Color.themeBlue)
                        .font(.custom(CFont.graphikSemibold.rawValue, size: 13))
                }
            }
            .padding(.horizontal, 40)
        }
        .frame(width: UIScreen.screenWidth - 40, height: 400)
        .background(.white)
        .cornerRadius(5.0)
    }
}

#Preview {
    NewCaseView()
}
