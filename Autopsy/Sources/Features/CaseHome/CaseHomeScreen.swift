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
        NavigationStack {
            TabView {
                Text("page 1")
                    .tabItem {
                        Text("page 1")
                    }
                
                Text("page 2")
                    .tabItem {
                        Text("page 2")
                    }
            }
        }
    }
}

#Preview {
    CaseHomeScreen()
}
