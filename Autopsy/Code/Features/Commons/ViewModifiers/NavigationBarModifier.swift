//
//  NavigationBarModifier.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 7/8/24.
//

import SwiftUI
import UIKit

struct NavigationBarModifier: ViewModifier {
    
    init(backgroundColor: UIColor = .systemBackground, foregroundColor: UIColor = .black, tintColor: UIColor?, withSeparator: Bool = true){
        
        guard let customFont = UIFont(name: CFont.graphikLight.rawValue, size: 15),
              let customFontLarge = UIFont(name: CFont.graphikRegular.rawValue, size: 25)
        else { return }
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.font: customFont, .foregroundColor: foregroundColor]
        navBarAppearance.largeTitleTextAttributes = [.font: customFontLarge, .foregroundColor: foregroundColor]
        navBarAppearance.backgroundColor = backgroundColor
        if withSeparator {
            navBarAppearance.shadowColor = .clear
        }
        
        let backImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        navBarAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        
        let barButtonItemAppearance = UIBarButtonItemAppearance()
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        navBarAppearance.backButtonAppearance = barButtonItemAppearance
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        if let tintColor = tintColor {
            UINavigationBar.appearance().tintColor = tintColor
        }
    }
    func body(content: Content) -> some View {
        content
    }
}

#Preview {
    NavigationStack {
        Text("My Text Text")
            .navigationTitle("Test title")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarModifier(backgroundColor: .systemBackground, foregroundColor: .black, tintColor: .black, withSeparator: true)
        
            
    }
}
