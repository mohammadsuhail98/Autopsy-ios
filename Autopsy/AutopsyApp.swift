//
//  AutopsyApp.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/7/24.
//

import SwiftUI

@main
struct AutopsyApp: App {
    
    init() {
        setupNavigationBarAppearance()
    }
    
    func setupNavigationBarAppearance(){
        guard let customFont = UIFont(name: CFont.graphikLight.rawValue, size: 15),
              let customFontLarge = UIFont(name: CFont.graphikRegular.rawValue, size: 25)
        else { return }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.titleTextAttributes = [.font: customFont, .foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.font: customFontLarge, .foregroundColor: UIColor.black]
        
        //Change the icon
        let backImage = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        
        let barButtonItemAppearance = UIBarButtonItemAppearance()
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance = barButtonItemAppearance
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .black
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
