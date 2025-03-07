//
//  WeatherView.swift
//  WeatherV1
//
//  Created by Tise on 3/7/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import SwiftUI

struct WeatherView: View {

    let weatherStruct: WeatherResponse

    @State private var showSearch = false
    @State private var query: String = ""
    @State private var selectedCity: String = ""

    var body: some View {
        VStack(alignment: .center) {
            
            // Display Timezone Instead of ID (since `id` is not in the API response)
            Text(weatherStruct.timezone)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
           
            
            Spacer()
            
            Text(selectedCity).opacity(selectedCity.isEmpty ? 0 : 1)
                .font(.title)
                .foregroundStyle(.primary)
            
            VStack(spacing: 16) {
                
                // Weather Condition Image & City Name
                Image(systemName: iconName(for: weatherStruct.current.weather.first?.main ?? ""))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)

                Text("\(kelvinToCelsius(weatherStruct.current.temp), specifier: "%.1f") °C")
                    .font(.system(size: 40))
                    .bold()

                Text(weatherStruct.current.weather.first?.description.capitalized ?? "Unknown")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                // Additional Weather Info
                HStack(spacing: 24) {
                    VStack {
                        Text("🌡️ Feels Like")
                        Text("\(kelvinToCelsius(weatherStruct.current.feels_like), specifier: "%.1f") °C")
                            .bold()
                    }
                    
              

                    VStack {
                        Text("💨 Wind")
                        Text("\(weatherStruct.current.wind_speed, specifier: "%.1f") m/s")
                            .bold()
                    }
            

                    VStack {
                        Text("💧 Humidity")
                        Text("\(weatherStruct.current.humidity)%")
                            .bold()
                    }
                }
                .padding(.top, 8)
                
                

                // Sunrise & Sunset
                HStack(spacing: 40) {
                    VStack {
                        Text("🌅 Sunrise")
                        Text(formatTime(weatherStruct.current.sunrise))
                            .bold()
                    }

                    VStack {
                        Text("🌇 Sunset")
                        Text(formatTime(weatherStruct.current.sunset))
                            .bold()
                    }
                }
                .padding(.top, 8)
            }
            .padding()
            
            // Search Button
            Button(action: {
                showSearch = true
            }) {
                Text("Search for new city")
            }
            .opacity(showSearch ? 0.0 : 1.0)
            .padding(.vertical)

            Spacer()
        }
        .padding()
        .sheet(isPresented: $showSearch) {
            HStack {
                TextField("Enter city name...", text: $query)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .textInputAutocapitalization(.words)
                    .onSubmit {
                        // if something is valid, then set the selected city
                        selectedCity = query
                        query = ""
                        showSearch = false
                        
                        
                        
                    }
            }
            .padding(.horizontal)
            .presentationDetents([.height(100)])  // Small bottom sheet
            .presentationDragIndicator(.visible)
        }
    }

    // Convert Kelvin to Celsius
    private func kelvinToCelsius(_ kelvin: Double) -> Double {
        kelvin - 273.15
    }

    // Convert UNIX timestamp to HH:mm format
    private func formatTime(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter.string(from: date)
    }

    // Map Weather Conditions to SF Symbols
    private func iconName(for weatherMain: String) -> String {
        switch weatherMain {
        case "Thunderstorm": return "cloud.bolt.rain.fill"
        case "Drizzle": return "cloud.drizzle.fill"
        case "Rain": return "cloud.rain.fill"
        case "Snow": return "cloud.snow.fill"
        case "Clear": return "sun.max.fill"
        case "Clouds": return "cloud.fill"
        default: return "cloud"
        }
    }
}

#Preview {
    WeatherView(weatherStruct: weatherResponseArr[0])
}
