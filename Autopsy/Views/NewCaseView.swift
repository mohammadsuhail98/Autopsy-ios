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
            NavigationView {
                Form {
                    Section(header: Text("New Case Information")) {
                        TextField("Case Name", text: $caseName)
                        
                        Picker("Case Type", selection: $caseType) {
                            ForEach(CaseType.allCases) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        TextField("Case Number", text: $caseNumber)
                            .keyboardType(.numberPad)
                    }
                    
                    Section(header: Text("Examiner Information")) {
                        TextField("Name", text: $examinerName)
                        TextField("Phone", text: $phone)
                            .keyboardType(.phonePad)
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                        TextField("Notes", text: $notes)
                    }
                }
                .navigationBarTitle("New Case")
            }
        }
}

#Preview {
    NewCaseView()
}
