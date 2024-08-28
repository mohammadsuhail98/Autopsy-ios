//
//  CaseDetailsScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 20/8/24.
//

import SwiftUI
import PopupView

struct CaseDetailsScreen: View {
    
    @StateObject var vm = CaseDetailsVM()
    @State var showEditCaseSheet: Bool = false

    var body: some View {
        
        ZStack {
            List {
                Section(header:
                            Text("Case Details")
                    .font(.custom(CFont.graphikMedium.rawValue, size: 17))
                    .foregroundColor(.textColor)
                    .padding(.vertical, 10)
                ) {
                    CaseDetailRow(label: "Case Name", value: vm.caseDetails.name ?? "")
                    CaseDetailRow(label: "Case Number", value: "\(vm.caseDetails.number ?? 0)")
                    CaseDetailRow(label: "Created Date", value: vm.caseDetails.formattedDate)
                    CaseDetailRow(label: "Case Type", value: "Single-User")
                    CaseDetailRow(label: "Case UUID", value: vm.caseDetails.deviceID ?? "")
                }
                .listRowBackground(Color.white)
                .headerProminence(.increased)
                
                Section(header:
                            Text("Examiner Details")
                    .font(.custom(CFont.graphikMedium.rawValue, size: 17))
                    .foregroundColor(.textColor)
                    .padding(.vertical, 10)
                ) {
                    CaseDetailRow(label: "Name", value: vm.caseDetails.examinerName ?? "")
                    CaseDetailRow(label: "Phone", value: vm.caseDetails.examinerPhone ?? "")
                    CaseDetailRow(label: "Email", value: vm.caseDetails.examinerEmail ?? "")
                    CaseDetailRow(label: "Notes", value: vm.caseDetails.examinerNotes ?? "")
                }
                .listRowBackground(Color.white)
                .headerProminence(.increased)
            }
            .navigationTitle("Case Details")
            .scrollContentBackground(.hidden)
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
            .customBackground()
            
            if vm.loading { LoadingHUDView(loading: $vm.loading) }

        }
        .popup(isPresented: $showEditCaseSheet) {
            EditCaseSheet(isShowing: $showEditCaseSheet,
                          caseNumber: "\(vm.caseDetails.number ?? 0)",
                          name: vm.caseDetails.examinerName ?? "",
                          phone: vm.caseDetails.examinerPhone ?? "",
                          email: vm.caseDetails.examinerEmail ?? "",
                          notes: vm.caseDetails.examinerNotes ?? "") { number, exName, exPhone, exEmail, exNotes in
                
                vm.updateCaseDetails(number: number, exName: exName, exPhone: exPhone, exEmail: exEmail, exNotes: exNotes)
            }
        } customize: { $0
                .position(.bottom)
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.4))
                .isOpaque(true)
                .useKeyboardSafeArea(true)
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
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    showEditCaseSheet = true
                } label: {
                    Text("Edit")
                        .font(.custom(CFont.graphikMedium.rawValue, size: 15))
                        .foregroundColor(Color.textColor)
                }
            }
        }
        
    }
}

private struct EditCaseSheet: View {
    
    @Binding var isShowing: Bool

    @State var caseNumber: String = ""
    @State var name: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var notes: String = ""

    var completion: ((String, String, String, String, String)->())
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Edit Case Details")
                        .font(.custom(CFont.graphikMedium.rawValue, size: 17))
                        .foregroundColor(.textColor)
                        .kerning(0.38)
                    
                    Spacer()
                    
                    Button {
                        isShowing = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                .padding(10)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.visible, edges: .bottom)
            
            Text("Case details")
                .listRowBackground(Color.clear)
                .font(.custom(CFont.graphikMedium.rawValue, size: 17))
                .foregroundColor(.textColor)
                .frame(maxWidth: .infinity)
            
            EntryFieldStackView(titleText: "Case Number", value: $caseNumber)

            Text("Examiner details")
                .listRowBackground(Color.clear)
                .font(.custom(CFont.graphikMedium.rawValue, size: 17))
                .foregroundColor(.textColor)
                .frame(maxWidth: .infinity)
            
            EntryFieldStackView(titleText: "Examiner Name", value: $name)

            EntryFieldStackView(titleText: "Examiner Phone", value: $phone)

            EntryFieldStackView(titleText: "Examiner Email", value: $email)

            EntryFieldStackView(titleText: "Examiner Notes", value: $notes)


            Button {
                completion(caseNumber, name, phone, email, notes)
                isShowing = false
            } label: {
                BorderedBtnLabelView(title: "Save Changes")
            }
            .padding(.vertical, 12)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.background.cornerRadius(18))
    }
}


struct CaseDetailsSectionHeader: View {
    
    var text: String = ""
    var completion: ((Int) -> Void)
    
    var body: some View {
        HStack {
            Text(text)
                .font(.custom(CFont.graphikMedium.rawValue, size: 17))
                .foregroundColor(.textColor)
                .padding(.vertical, 10)
            
            Spacer()
            
            Button(action: {
                completion(text.lowercased() == "case details" ? 0 : 1)
            }) {
                Text("Edit")
                    .font(.custom(CFont.graphikRegular.rawValue, size: 12))
                    .foregroundColor(Color.themeBlue)
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.themeBlue, lineWidth: 1)
                    )
            }
        }
    }
}

struct CaseDetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                .foregroundColor(.textColor)
        }
        .padding(.vertical, 10)
        
    }
}

#Preview {
    CaseDetailsScreen()
}
