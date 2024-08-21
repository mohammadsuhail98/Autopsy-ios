//
//  CaseDetailsScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 20/8/24.
//

import SwiftUI

struct CaseDetailsScreen: View {
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
             }) {
                 CaseDetailRow(label: "Case Name", value: "Forensics Test Case")
                 CaseDetailRow(label: "Case Number", value: "23")
                 CaseDetailRow(label: "Created Date", value: "2024/07/10 23:54:00 (CEST)")
                 CaseDetailRow(label: "Case Type", value: "Single-User Case")
                 CaseDetailRow(label: "Case UUID", value: "99c1cc72-c618-4566-aead-efe316082f1d")
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
             }) {
                 CaseDetailRow(label: "Name", value: "Test Examiner")
                 CaseDetailRow(label: "Phone", value: "+34 542 56 37 14")
                 CaseDetailRow(label: "Email", value: "email@email.com")
                 CaseDetailRow(label: "Notes", value: "No Notes")
             }
             .listRowBackground(Color.white)
             .headerProminence(.increased)
         }
        .scrollContentBackground(.hidden)
        .shadow(color: .shadow, radius: 2, x: 1, y: 1)
        .customBackground()

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
