//
//  ContentView.swift
//  SwiftUI_WeatherApp
//
//  Created by Prathamesh Pawar on 4/22/25.
//

import SwiftUI

struct WeatherTabView: View {
    
    let defaultCities = ["New Delhi", "Mumbai", "Pune", "Baramati", "Bangalore"]
    
    var body: some View {
        TabView {
            ForEach(defaultCities, id: \.self) { city in
                WeatherContentView(city: city)
                    .tabItem {
                        Label(city, systemImage: "location.circle")
                    }
            }
        }
    }
}


struct WeatherContentView: View {
    
    let originalCity: String
    
    @State var city: String

    @StateObject var viewModel = WeatherViewModel()
    @State private var isNight = false
    @State private var isEditingCity = false
    
    init(city: String) {
        self.originalCity = city
        _city = State(initialValue: city)
    }
    
    
    var body: some View {
        
        ZStack {
            
            BackgroundView(isNight: $isNight)
            
            VStack {
                
                if isEditingCity {
                    TextField("Enter city", text: $city, onCommit: {
                        isEditingCity = false
                        viewModel.fetchWeather(for: city)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .multilineTextAlignment(.center)
                } else {
                    Text(city)
                        .font(.system(size: 32, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding()
                        .onTapGesture {
                            isEditingCity = true
                        }
                }
                
                if let today = viewModel.weatherData.first {
                    MainWeatherStatusView(
                        imageName: today.imageName,
                        temperature: today.temperature
                    )
                    
                    
                    HStack(spacing: 22) {
                        ForEach(viewModel.weatherData.dropFirst(), id: \.id.self) { day in
                            WeatherDayView(
                                dayOfWeek: day.dayOfWeek,    
                                imageName: day.imageName,
                                temperature: day.temperature
                            )
                        }
                    }
                }
               
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Time of Day", 
                                  backgroundColor: .white,
                                  textColor: .blue)
                }
                
                Spacer()
                
            }
        }
        .onAppear {
            city = originalCity
            viewModel.fetchWeather(for: city)
        }
        
    }
}

#Preview {
    WeatherTabView()
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Text(dayOfWeek)
                .font(.system(size: 20, weight: .heavy))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
        }
    }
}


struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 35, weight: .bold, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 72, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(.bottom, 90)
    }
}

