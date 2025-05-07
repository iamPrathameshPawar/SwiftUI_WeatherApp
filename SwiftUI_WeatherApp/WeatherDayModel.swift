//
//  WeatherDayModel.swift
//  SwiftUI_WeatherApp
//
//  Created by Prathamesh Pawar on 4/27/25.
//

import Foundation

struct WeatherDay: Identifiable {
    let id = UUID()
    let dayOfWeek: String
    let imageName: String
    let temperature: Int
}

// JSON to Struct decoding

struct WeatherAPIResponse: Codable {
    let forecast: Forecast
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let day: Day
}

struct Day: Codable {
    let avgtemp_c: Double
    let condition: Condition
}

struct Condition: Codable {
    let text: String
    let icon: String
}
