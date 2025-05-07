//
//  WeatherButton.swift
//  SwiftUI_WeatherApp
//
//  Created by Prathamesh Pawar on 4/25/25.
//

import SwiftUI

struct WeatherButton: View {
    
    var title: String
    var backgroundColor: Color
    var textColor: Color
    
    var body: some View {
        Text(title)
        .frame(width: 280, height: 50)
        .foregroundColor(textColor)
        .background(backgroundColor)
        .font(.system(size: 20, weight: .bold, design: .default))
        .cornerRadius(10)
    }
}
