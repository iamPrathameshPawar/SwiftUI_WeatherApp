//
//  SwiftUI_WeatherAppApp.swift
//  SwiftUI_WeatherApp
//
//  Created by Prathamesh Pawar on 4/22/25.
//

import SwiftUI

@main
struct SwiftUI_WeatherAppApp: App {
    
    init() {
          UITabBar.appearance().unselectedItemTintColor = UIColor.darkGray
    }
    
    var body: some Scene {
        WindowGroup {
            WeatherTabView()
        }
    }
}
