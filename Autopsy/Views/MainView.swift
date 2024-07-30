//
//  MainView.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/7/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            backgroundView()
            VStack {
                Spacer()
                mainImageView()
                VStack {
                    Button { print("New case") } label: {
                        FilledIconButtonView(title: "New Case", image: "new_case")
                    }
                    Button { print("Open case") } label: {
                        FilledIconButtonView(title: "Open Case", image: "open_case")
                    }
                }
                Spacer()
                DocLinkView(title: "Online Autopsy Documentation >")
            }
        }
    }
    
}

struct mainImageView: View {
    var body: some View {
        Image("main_screen_logo")
            .imageScale(.large)
            .foregroundStyle(.tint)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
    }
}

struct FilledIconButtonView: View {
    var title: String
    var image: String
    
    var body: some View {
        Label(title, image: image)
            .frame(width: 300, height: 70)
            .background(Color.white)
            .foregroundColor(Color.textColor)
            .cornerRadius(5)
            .font(.system(size: 15, weight: .bold))
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
    }
}

struct DocLinkView: View {
    var title: String
    
    var body: some View {
        Link(title, destination: URL(string: "https://www.sleuthkit.org/autopsy/docs.php")!)
            .font(Font(CTFont(.label, size: 13)))
            .fontWeight(.light)
            .foregroundColor(.textColor)
    }
}

struct backgroundView: View {
    var body: some View {
        Color.background
            .ignoresSafeArea()
    }
}

#Preview {
    MainView()
}
