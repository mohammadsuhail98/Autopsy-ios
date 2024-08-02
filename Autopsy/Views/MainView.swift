//
//  MainView.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/7/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundView()
                VStack {
                    Spacer()
                    mainImageView()
                    VStack {
                        NavigationLink(destination: NewCaseView()) {
                            FilledIconButtonView(title: "New Case", image: "new_case")
                        }
                        NavigationLink(destination: NewCaseView()) {
                            FilledIconButtonView(title: "Open Case", image: "open_case")
                        }
                    }
                    Spacer()
                    DocLinkView(title: "Online Autopsy Documentation >")
                }
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
