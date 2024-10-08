//
//  NewCaseScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 30/7/24.
//

import SwiftUI
import PopupView
import ActivityIndicatorView

struct NewCaseScreen: View {
    
    @StateObject var vm = NewCaseVM()
    @EnvironmentObject private var router: Router
    
    @State private var showingResultPopup = false


    var body: some View {
        
        ZStack {
            Form {
                
                Section(header: Text("New Case Information")
                    .font(.custom(CFont.graphikMedium.rawValue, size: 17))
                    .foregroundColor(.textColor)
                    .frame(width: UIScreen.screenWidth - 75, height: 50)
                    .textCase(.none)
                ) {
                    EntryFieldStackView(titleText: "Case Name", value: $vm.caseRequest.name)
                    EntryFieldStackView(titleText: "Case Number", value: $vm.caseRequest.number, optional: true)
                }
                
                Section(header: Text("Examiner Information")
                    .font(.custom(CFont.graphikMedium.rawValue, size: 17))
                    .foregroundColor(.textColor)
                    .frame(width: UIScreen.screenWidth - 75, height: 50)
                    .textCase(.none)) {
                        EntryFieldStackView(titleText: "Name", value: $vm.caseRequest.examinerName, optional: true)
                        EntryFieldStackView(titleText: "Phone", value: $vm.caseRequest.examinerPhone, optional: true)
                        EntryFieldStackView(titleText: "Email", value: $vm.caseRequest.examinerEmail, optional: true)
                        TextEditorView(titleText: "Notes", value: $vm.caseRequest.examinerNotes)
                    }
                
                Button {
                    vm.sendData { caseEntity in
                        FocusedCase.shared.setCase(caseItem: caseEntity)
                        showingResultPopup = true
                    } errorBlock: { error in
                        
                    }
                } label: {
                    BorderedBtnLabelView(title: "Finish")
                }
                .listRowBackground(Color.background)
                
            }
            .scrollContentBackground(.hidden)
            .customBackground()
            .navigationBarTitle("New Case", displayMode: .inline)
            .navigationBarModifier(backgroundColor: .systemBackground, foregroundColor: .black, tintColor: .black, withSeparator: false)
            
            if vm.loading { LoadingHUDView(loading: $vm.loading) }
            
        }
        .popup(isPresented: $showingResultPopup) {
            ResultPopupView { tag in
                vm.updateRoutes(tag, router: router)
            }
        } customize: { $0
            .isOpaque(true)
            .type(.floater(verticalPadding: 20, horizontalPadding: 20, useSafeAreaInset: true))
            .position(.center)
            .animation(.spring())
            .closeOnTapOutside(true)
            .backgroundColor(.black.opacity(0.5))
        }
        .popup(isPresented: $vm.showErrorPopup) {
            ErrorToastView(msg: vm.errMsg)
        } customize: { $0
            .type(.floater())
            .position(.bottom)
            .animation(.spring())
            .closeOnTapOutside(true)
            .autohideIn(2)
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
        .listRowBackground(Color.background)
        .padding(.vertical, 5)
    }
}

struct ErrorToastView: View {
    
    var msg: String = "Unknown error has occurred!"
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "exclamationmark.circle")
                .foregroundColor(.white)
                .font(.system(size: 25))
            
            Text(msg)
                .foregroundColor(.white)
                .font(.system(size: 15))
        }
        .padding(16)
        .background(Color(hex: 0xe52d2d).cornerRadius(12))
        .padding(.horizontal, 16)
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
    NewCaseScreen()
}
