//
//  FileResultsViewer.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 2/9/24.
//

import SwiftUI

struct FileResultsViewer: View {
    
    var results: FileResults
    
    var body: some View {
        
        VStack {
            List {
                Section {
                    
                    if let resultsArr = results.analysisResults {
                        ForEach(0..<(resultsArr.count ), id: \.self) { index in
                            
                            Text("Analysis Results \(index + 1)")
                                .font(.custom(CFont.graphikSemibold.rawValue, size: 15))
                                .foregroundColor(.textColor)
                                .listRowBackground(Color.background)
                            
                            if let score = resultsArr[index].score, !score.isEmpty {
                                FileResultCell(label: "Score", value: score)
                            }
                            if let type = resultsArr[index].type, !type.isEmpty {
                                FileResultCell(label: "Type", value: type)
                            }
                            if let configuration = resultsArr[index].configuration, !configuration.isEmpty {
                                FileResultCell(label: "Configuration", value: configuration)
                            }
                            if let conclusion = resultsArr[index].conclusion, !conclusion.isEmpty {
                                FileResultCell(label: "Conclusion", value: conclusion)
                            }
                            if let justification = resultsArr[index].justification, !justification.isEmpty {
                                FileResultCell(label: "Justification", value: justification)
                            }
                            if let altitude = resultsArr[index].altitude, !altitude.isEmpty {
                                FileResultCell(label: "Altitude", value: altitude)
                            }
                            if let latitude = resultsArr[index].latitude, !latitude.isEmpty {
                                FileResultCell(label: "Latitude", value: latitude)
                            }
                            if let longitude = resultsArr[index].longitude, !longitude.isEmpty {
                                FileResultCell(label: "Longitude", value: longitude)
                            }
                            if let dateCreated = resultsArr[index].dateCreated, !dateCreated.isEmpty {
                                FileResultCell(label: "Date Created", value: dateCreated)
                            }
                            if let deviceMake = resultsArr[index].deviceMake, !deviceMake.isEmpty {
                                FileResultCell(label: "Device Make", value: deviceMake)
                            }
                            if let deviceModel = resultsArr[index].deviceModel, !deviceModel.isEmpty {
                                FileResultCell(label: "Device Model", value: deviceModel)
                            }
                            if let comment = resultsArr[index].comment, !comment.isEmpty {
                                FileResultCell(label: "Comment", value: comment)
                            }
                            Divider()
                                .listRowBackground(Color.background)
                                .padding(.vertical, 5)
                        }
                    }
                } header: {
                    VStack {
                        FileResultHeaderCell(label: "Item", value: results.itemName ?? "")
                        FileResultHeaderCell(label: "Aggregate Score", value: results.aggregateScore ?? "")
                        Divider()
                            .background(Color.background)
                            .padding(.top, 5)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .customBackground()
            .scrollIndicators(.hidden)
            .listRowSeparator(.hidden)
        }
        .padding(.horizontal, 10)
        
    }
}

struct FileResultHeaderCell: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                .foregroundColor(.gray)
                .padding(.trailing, 10)
            Text(value)
                .font(.custom(CFont.graphikMedium.rawValue, size: 14))
                .foregroundColor(.textColor)
                .textSelection(.enabled)
            Spacer()
        }
        .padding(.vertical, 5)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

struct FileResultCell: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                .foregroundColor(.gray)
            Text(value)
                .font(.custom(CFont.graphikMedium.rawValue, size: 14))
                .foregroundColor(.textColor)
                .textSelection(.enabled)
            Spacer()
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .listRowBackground(Color.background)
        .listRowSeparator(.hidden)
    }
}
