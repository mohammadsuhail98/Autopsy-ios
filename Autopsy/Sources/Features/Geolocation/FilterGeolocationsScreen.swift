//
//  FilterGeolocationsScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 28/8/24.
//

import SwiftUI

struct FilterGeolocationsScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var vm: GeoLocationVM
    
    var body: some View {
        
        VStack {
            
            HStack {
                Button {
                    vm.showFilterScreen = false
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color.textColor)
                        .font(.custom(CFont.graphikMedium.rawValue, size: 15))
                }
                
                Spacer()
                
                Text("Filter")
                    .foregroundColor(Color.textColor)
                    .font(.custom(CFont.graphikLight.rawValue, size: 15))
                
                Spacer()
                
                Button {
                    vm.showFilterScreen = false
                    vm.getLocationsByDataSourceIds()
                } label: {
                    Text("Apply")
                        .foregroundColor(Color.themeBlue)
                        .font(.custom(CFont.graphikMedium.rawValue, size: 15))
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            
            Form {
                
                Section {
                    VStack(alignment: .leading) {
                        
                        Text("Show:")
                            .font(.custom(CFont.graphikMedium.rawValue, size: 15))
                            .padding(10)
                        
                        Picker("", selection: $vm.showAll) {
                            Text("All").tag(true)
                            Text("Days Of Activity").tag(false)
                        }
                        .pickerStyle(.segmented)
                        
                        EntryFieldStackView(titleText: "Last Days Of Activity", value: $vm.lastDaysOfActivity, withTitle: false)
                            .disabled(vm.showAll)
                            .padding(.top, 5)
                    }
                } header: {
                    VStack {
                        HStack {
                            Text("Dates")
                                .font(.custom(CFont.graphikSemibold.rawValue, size: 17))
                                .foregroundColor(.textColor)
                                .padding(.bottom, 10)
                            Spacer()
                        }

                        Divider()
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                Section {
                    ForEach(FocusedCase.shared.getCase()?.dataSourceList ?? []) { dataSource in
                        HStack {
                            
                            FilterCheckBoxView(checked: vm.selectedDataSourcesIds.contains(dataSource.dataSourceID ?? 0)) {
                                if vm.selectedDataSourcesIds.contains(dataSource.dataSourceID ?? 0) {
                                    vm.selectedDataSourcesIds.remove(dataSource.dataSourceID ?? 0)
                                } else {
                                    vm.selectedDataSourcesIds.insert(dataSource.dataSourceID ?? 0)
                                }
                            }
                            Text(dataSource.name ?? "")
                                .font(.custom(CFont.graphikRegular.rawValue, size: 15))
                                .foregroundColor(Color.textColor)

                        }
                    }
                } header: {
                    VStack {
                        HStack {
                            Text("Data Sources")
                                .font(.custom(CFont.graphikSemibold.rawValue, size: 17))
                                .foregroundColor(.textColor)
                                .padding(.bottom, 10)
                            Spacer()
                        }

                        Divider()
                    }
                    
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden, edges: .bottom)
            }
            .scrollContentBackground(.hidden)

        }
        .customBackground()
    }
}

struct FilterCheckBoxView: View {
    var checked: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .foregroundColor(checked ? .textColor : .textColor)
                .font(.title3)
        }
    }
}
