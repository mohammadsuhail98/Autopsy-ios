//
//  CaseHomeScreen.swift
//  Autopsy
//
//  Created by mohammad suhail on 10/8/24.
//

import SwiftUI

struct CaseHomeScreen: View {
    
    @EnvironmentObject private var router: Router
    @State var selection = 0
    @StateObject var dataSourceListVM = DataSourceListVM()
    @StateObject var analysisResultsVM = AnalysisResultsVM()
    @StateObject var caseVM = CaseVM()

    var body: some View {
        TabView(selection: $selection) {
            DataSourceListScreen()
                .tabItem {
                    TabItemView(icon: "data_sources_tabbar", text: "Data Sources")
                }.tag(0)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.light, for: .tabBar)
                .environmentObject(dataSourceListVM)
            
            FileViewsScreen()
                .tabItem {
                    TabItemView(icon: "views_tabbar", text: "Views")
                }.tag(1)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.light, for: .tabBar)
            
            AnalysisResultsScreen()
                .tabItem {
                    TabItemView(icon: "results_tabbar", text: "Results")
                }.tag(2)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.light, for: .tabBar)
                .environmentObject(analysisResultsVM)

            CaseScreen()
                .tabItem {
                    TabItemView(icon: "case_tabbar", text: "Case")
                }.tag(3)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.light, for: .tabBar)
                .environmentObject(caseVM)
        }
        .navigationTitle(selection == 0 ? "Case Name" : getNavBarTitle(selection: selection))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            if selection == 0 {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button {
                        router.caseHomePath.append(.addDataSourceType)
                    } label: {
                        Image("add")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.textColor)
                    }
                }
            }
        }
        
    }
    
    func getNavBarTitle(selection: Int) -> String {
        switch selection {
        case 1: return "Files Views"
        case 2: return "Analysis Results"
        case 3: return "Case"
        default: return ""
        }
    }
    
}

#Preview {
    CaseHomeScreen()
}

struct TabItemView: View {
    
    var icon: String
    var text: String
    
    var body: some View {
        VStack {
            Image(icon)
                .renderingMode(.template)
            Text(text)
        }
    }
}
