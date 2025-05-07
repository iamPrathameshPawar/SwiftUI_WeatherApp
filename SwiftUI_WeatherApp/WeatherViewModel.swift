//
//  WeatherViewModel.swift
//  SwiftUI_WeatherApp
//
//  Created by Prathamesh Pawar on 4/27/25.
//

import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published var weatherData: [WeatherDay] = []

    func fetchWeather(for city: String) {
        
        guard let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=458f60633c2040d6b1425128252804&q=\(city)&days=7") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        if jsonString.isEmpty {
                            print("No response from weatherAPI...!")
                        } else {
                            print(jsonString)
                        }
                    }
                    
                    let decodedResponse = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
                    
                    DispatchQueue.main.async { [self] in
                        self.weatherData = decodedResponse.forecast.forecastday.map { day in
                            WeatherDay(
                                dayOfWeek: getDayOfWeek(from: day.date),
                                imageName: getImageName(for: day.day.condition.text),
                                temperature: Int(day.day.avgtemp_c)
                            )
                        }
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            } else if let error = error {
                print("Network error: \(error)")
            }
        }.resume()
        
    }
    
    func getDayOfWeek(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        if let date = formatter.date(from: dateString) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEE"
            return dayFormatter.string(from: date)
        }
        return "N/A"
    }

    func getImageName(for condition: String) -> String {
        
        switch condition.lowercased() {
            
            case let text where text.contains("sun"):
                return "sun.max.fill"
            
            case let text where text.contains("cloud"):
                return "cloud.fill"
            
            case let text where text.contains("rain"):
                return "cloud.rain.fill"
            
            default:
                return "questionmark.circle"
            
        }
        
    }

    
}

