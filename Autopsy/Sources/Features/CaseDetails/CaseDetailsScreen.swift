//
//  CaseDetailsScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 20/8/24.
//

import SwiftUI

struct CaseDetailsScreen: View {
    
    @StateObject var vm = CaseDetailsVM()

    var body: some View {
        
        List {
             Section(header: HStack {
                 Text("Case Details")
                     .font(.custom(CFont.graphikMedium.rawValue, size: 17))
                     .foregroundColor(.textColor)
                     .padding(.vertical, 10)

                 Spacer()
                 
                 Button(action: {

                 }) {
                     CaseDetailsEditButton()
                 }
                 
             }) {
                 CaseDetailRow(label: "Case Name", value: vm.caseDetails.name ?? "")
                 CaseDetailRow(label: "Case Number", value: "\(vm.caseDetails.number ?? 0)")
                 CaseDetailRow(label: "Created Date", value: vm.caseDetails.formattedDate)
                 CaseDetailRow(label: "Case Type", value: "Single-User")
                 CaseDetailRow(label: "Case UUID", value: vm.caseDetails.deviceID ?? "")
             }
             .listRowBackground(Color.white)
             .headerProminence(.increased)
            
             Section(header: HStack {
                 
                 Text("Examiner Details")
                     .font(.custom(CFont.graphikMedium.rawValue, size: 17))
                     .foregroundColor(.textColor)
                     .padding(.vertical, 10)
                 
                 Spacer()
                 
                 Button(action: {
                    
                 }) {
                    CaseDetailsEditButton()
                 }
             }) {
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

    }
}

struct CaseDetailsEditButton: View {
    var body: some View {
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
