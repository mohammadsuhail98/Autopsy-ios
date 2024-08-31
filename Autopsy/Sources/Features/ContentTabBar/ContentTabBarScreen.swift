//
//  ContentTabBarScreen.swift
//  Autopsy
//
//  Created by mohammad suhail on 31/8/24.
//

import SwiftUI

struct ContentTabBarScreen: View {
    
    @EnvironmentObject private var router: Router
    @State var selection = 0
    
    var mainInfo: AutopsyFile
    var content: AutopsyFiles
    var title: String
    
    var body: some View {
        TabView(selection: $selection) {
            if !content.isEmpty {
                ContentFilesScreen(contentFiles: content)
                    .tabItem {
                        TabItemView(icon: "files_tabbar", text: "Files")
                    }.tag(0)
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarColorScheme(.light, for: .tabBar)
            }

            ContentFileInfoScreen(autopsyFile: mainInfo)
                .tabItem {
                    TabItemView(icon: "information", text: "Information")
                }.tag(1)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.light, for: .tabBar)
            
            Text("Data Content")
                .tabItem {
                    TabItemView(icon: "data_content", text: "Data Content")
                }.tag(2)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.light, for: .tabBar)

        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentTabBarScreen(mainInfo: AutopsyFile(), content: AutopsyFiles(), title: "")
}
