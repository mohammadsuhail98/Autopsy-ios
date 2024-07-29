//
//  ContentView.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("main_screen_logo")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
            Button(action: {
                
            }) {
                Label("New Case", image: "new_case")
                .frame(width: 250, height: 40)
                .padding()
                .background(Color.white)
                .foregroundColor(Color.textColor)
                .clipShape(.rect(cornerRadii: .init(topLeading: 5, bottomLeading: 5, bottomTrailing: 5, topTrailing: 5)))
                .font(Font(CTFont(.label, size: 15)))
                .bold()
                .shadow(color: .shadow, radius: 2, x: 1, y: 1)
                .dialogIcon(Image("new_case"))
            }

            Button(action: {
                
            }) {
                Label("Open Case", image: "open_case")
                .frame(width: 250, height: 40)
                .padding()
                .background(Color.white)
                .foregroundColor(Color.textColor)
                .clipShape(.rect(cornerRadii: .init(topLeading: 5, bottomLeading: 5, bottomTrailing: 5, topTrailing: 5)))
                .font(Font(CTFont(.label, size: 15)))
                .bold()
                .shadow(color: .shadow, radius: 2, x: 1, y: 1)
                .dialogIcon(Image("new_case"))
            }
            
            Spacer()
            
            Link("Online Autopsy Documentation >", destination: URL(string: "https://www.sleuthkit.org/autopsy/docs.php")!)
                .font(Font(CTFont(.label, size: 13)))
                .fontWeight(.light)
                .foregroundColor(.textColor)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
    
}

#Preview {
    ContentView()
}
