//
//  MainView.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/7/24.
//

import SwiftUI

struct MainView: View {
    
    let recentCases = [
        Case(name: "Case 1", creationDate: "January 1, 2023"),
        Case(name: "Case 2", creationDate: "February 2, 2023"),
        Case(name: "Case 3", creationDate: "March 3, 2023")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundView()
                VStack {
                    mainImageView()
                    VStack {
                        NavigationLink(destination: NewCaseView()) {
                            FilledIconButtonView(title: "New Case", image: "new_case")
                        }
                        RecentCasesView(recentCases: recentCases)
                            .padding(.top, 16)
                    }
                    Spacer()
                    DocLinkView(title: "Online Autopsy Documentation >")
                }
                .padding(.top, 50)
            }
        }
    }
    
}

struct mainImageView: View {
    var body: some View {
        Image("main_screen_logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 280)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))

    }
}

struct RecentCasesView: View {
    let recentCases: [Case]
    
    var body: some View {
        VStack() {
            Section(header: RecentCasesSectionView()) {
                List(recentCases) { caseItem in
                    CaseItemView(caseItem: caseItem)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct RecentCasesSectionView: View {
    var body: some View {
        Text("Recent Cases")
            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            .font(.custom(CFont.graphikMedium.rawValue, size: 18))
            .foregroundColor(.textColor)
            .padding(.horizontal, 30)
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

#Preview {
    MainView()
}
