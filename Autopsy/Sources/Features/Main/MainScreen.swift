//
//  MainView.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/7/24.
//

import SwiftUI
import PopupView

struct MainScreen: View {
    
    @EnvironmentObject private var vm: MainVM
    @EnvironmentObject private var router: Router

    @StateObject var caseDetailsVM = CaseDetailsVM()
    @StateObject var geolocationVM = GeoLocationVM()
    @StateObject var analysisResultsFilesVM = AnalysisResultsFilesVM()
    @StateObject var filesByTypeVM = FilesByTypeVM()
    @StateObject var mimeTypesVM = MimeTypesVM()
    @StateObject var dsContentVM = DSContentVM()
    
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
                        List {
                            ForEach(vm.recentCases) { caseItem in
                                CaseItemView(caseItem: caseItem)
                                    .onTapGesture {
                                        FocusedCase.shared.setCase(caseItem: caseItem)
                                        router.selectedScenario = .caseHome
                                    }
                            }
                            .listRowBackground(Color.clear)
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
                .onAppear {
                    vm.getCases()
                }
                .popup(isPresented: $vm.showErrorPopup) {
                    ErrorToastView(msg: vm.errMsg)
                } customize: { $0
                    .type(.floater())
                    .position(.bottom)
                    .animation(.spring())
                    .closeOnTapOutside(true)
                    .autohideIn(2)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarModifier(backgroundColor: .systemBackground, foregroundColor: .black, tintColor: .black, withSeparator: true)
                .navigationDestination(for: CaseCreationPath.self) { path in
                    switch path {
                    case .mainScreen: MainScreen()
                    case .newCase: NewCaseScreen()
                    case .addDataSourceType: AddDataSourceTypeView()
                    case .addDataSource: SelectDataSourceView()
                    case .ingestModules: IngestModulesView()
                    }
                }
            }
            
        case .caseHome:
            NavigationStack(path: $router.caseHomePath) {
                CaseHomeScreen()
                    .navigationDestination(for: CaseHomePath.self) { path in
                        switch path {
                        case .caseDetails: 
                            CaseDetailsScreen()
                                .environmentObject(caseDetailsVM)
                        case .addDataSourceType: AddDataSourceTypeView()
                        case .addDataSource: SelectDataSourceView()
                        case .ingestModules: IngestModulesView()
                        case .dataSourceList: CaseHomeScreen()
                        case .dataSourceContent(let dataSource):
                            DSContentScreen(dataSource: dataSource)
                                .environmentObject(dsContentVM)
                        case .newCase: NewCaseScreen()
                        case .geolocation:
                            GeoLocationScreen()
                                .environmentObject(geolocationVM)
                        case .analysisResultsFiles(let type):
                            AnalysisResultsFilesScreen(type: type)
                                .environmentObject(analysisResultsFilesVM)
                        case .filesByViewType(let viewType):
                            FilesByTypeScreen(type: viewType)
                                .environmentObject(filesByTypeVM)
                        case .filesByExtension:
                            FilesByExtensionScreen()
                        case .mimeTypes:
                            MimeTypesScreen()
                                .environmentObject(mimeTypesVM)
                        case .contentTabBar(let fileInfo, let content, let title):
                            ContentTabBarScreen(mainInfo: fileInfo, content: content, title: title)
                        }
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarModifier(backgroundColor: .themeBackgroud, foregroundColor: .black, tintColor: .black, withSeparator: true)
            
        }
    }
    
}

struct CaseItemView: View {
    let caseItem: CaseEntity
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(caseItem.name ?? "")
                    .font(.custom(CFont.graphikMedium.rawValue, size: 15))
                    .padding(.bottom, 5)
                    .foregroundColor(.textColor)
                Text(caseItem.formattedDate)
                    .font(.custom(CFont.graphikLight.rawValue, size: 15))
                    .padding(.bottom, 5)
                    .foregroundColor(.textColor)
            }
            
            Spacer()
        }
        .padding(.leading, 20)
        .padding(.bottom, 5)
        .contentShape(Rectangle())
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
