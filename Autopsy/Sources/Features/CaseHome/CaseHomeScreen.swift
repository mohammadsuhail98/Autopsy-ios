//
//  CaseHomeScreen.swift
//  Autopsy
//
//  Created by mohammad suhail on 10/8/24.
//

import SwiftUI

struct CaseHomeScreen: View {
    
    @EnvironmentObject private var router: Router
    
    var body: some View {
        TabView {
            DataSourceListScreen()
                .tabItem {
                    TabItemView(icon: "data_sources_tabbar", text: "Data Sources")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.light, for: .tabBar)
            
            Text("Views")
                .tabItem {
                    TabItemView(icon: "views_tabbar", text: "Views")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.light, for: .tabBar)
            
            Text("Results")
                .tabItem {
                    TabItemView(icon: "results_tabbar", text: "Results")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.light, for: .tabBar)
            
            CaseScreen()
                .tabItem {
                    TabItemView(icon: "case_tabbar", text: "Case")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.light, for: .tabBar)
        }
        .navigationBarTitle("Case Name ", displayMode: .inline)
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
