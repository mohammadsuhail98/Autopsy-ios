//
//  MainView.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/7/24.
//

import SwiftUI

struct MainScreen: View {
    @Environment(\.mainVM) private var vm: MainVM
    @EnvironmentObject private var router: Router
    

    var body: some View {
        
        switch router.selectedScenario {
            
        case .caseCreation:
            
            NavigationStack(path: $router.caseCreationPath) {
                VStack {
                    Image("main_screen_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 280)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
                    
                    Button("New Case") {
                        router.caseCreationPath.append(.newCase)
                    }
                    .buttonStyle(.autopsy(icon: "new_case"))
                    
                    Section {
                        List(vm.recentCases) { caseItem in
                            CaseItemView(caseItem: caseItem)
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    } header: {
                        Text("Recent Cases")
                            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                            .font(.custom(CFont.graphikMedium.rawValue, size: 18))
                            .foregroundColor(.textColor)
                            .padding(.horizontal, 30)
                    }
                    .padding(.top, 16)
                    
                    Spacer()
                    
                    DocLinkView(title: "Online Autopsy Documentation >")
                }
                .padding(.top, 50)
                .customBackground()
                .navigationDestination(for: CaseCreationPath.self) { path in
                    switch path {
                    case .newCase:
                        NewCaseView()
                        
                    case .addDataSourceType:
                        AddDataSourceTypeView()
                        
                    case .addDataSource:
                        SelectDataSourceView()
                        
                    case .ingestModules:
                        IngestModulesView()
                    }
                }
            }
            
        case .caseHome:
            NavigationStack(path: $router.caseCreationPath) {
                CaseHomeScreen()
                    .navigationDestination(for: CaseHomePath.self) { path in
                        switch path {
                        case .test:
                            EmptyView()
                        }
                    }
            }
            
        }
    }
    
}

struct CaseItemView: View {
    let caseItem: Case

    var body: some View {
        VStack(alignment: .leading) {
            Text(caseItem.name)
                .font(.custom(CFont.graphikMedium.rawValue, size: 15))
                .padding(.bottom, 5)
                .foregroundColor(.textColor)
            Text(caseItem.creationDate)
                .font(.custom(CFont.graphikLight.rawValue, size: 15))
                .padding(.bottom, 5)
                .foregroundColor(.textColor)
        }
        .padding(.leading, 20)
        .padding(.bottom, 5)
        .listRowBackground(Color.clear)
    }
}

struct DocLinkView: View {
    var title: String
    
    var body: some View {
        Link(title, destination: URL(string: "https://www.sleuthkit.org/autopsy/docs.php")!)
            .font(Font.custom(CFont.graphikLight.rawValue, size: 13))
            .foregroundColor(.textColor)
    }
}

struct FilledIconButtonView: View {
    var title: String
    var image: String
    
    var body: some View {
        Label(title, image: image)
            .font(Font.custom(CFont.graphikMedium.rawValue, size: 15))
            .frame(width: 300, height: 70)
            .background(Color.white)
            .foregroundColor(Color.textColor)
            .cornerRadius(5)
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
    }
}

#Preview {
    MainScreen().environment(\.mainVM, MainVM())
}
