//
//  WeatherView.swift
//  WeatherV1
//
//  Created by Tise on 3/7/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import SwiftUI

struct WeatherView: View {

    let weatherStruct: WeatherResponse?

    @Binding var query: String
    @Binding var selectedCity: String
    @Binding var errMessage: String

    @State private var showSearch: Bool = false

    var body: some View {

        VStack(alignment: .center) {
            if let weather: WeatherResponse = weatherStruct {
                Text(weather.id.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(selectedCity).opacity(selectedCity.isEmpty ? 0 : 1)
                    .font(.title)
                    .foregroundStyle(.primary)
                VStack(spacing: 16) {
                    // Weather Condition Icon
                    Image(
                        systemName: iconName(
                            for: weather.weather.first?.main ?? "")
                    )
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)

                    Text(
                        "\(kelvinToCelsius(weather.main.temp), specifier: "%.1f") °C"
                    )
                    .font(.system(size: 40))
                    .bold()

                    Text(
                        weather.weather.first?.description.capitalized
                            ?? "Unknown"
                    )
                    .font(.title3)
                    .foregroundStyle(.secondary)

                    // Additional Weather Info
                    HStack(spacing: 24) {
                        WeatherInfoView(
                            title: "🌡️ Feels Like",
                            value: "\(String(format: "%.1f", kelvinToCelsius(weather.main.feels_like))) °C"

                        )
                        WeatherInfoView(
                            title: "🗺️ Coordinates",
                            value: "X: \(weather.coord.lat) Y: \(weather.coord.lon)")
                        WeatherInfoView(
                            title: "💧 Humidity",
                            value: "\(weather.main.humidity)%")
                    
                    }
                    .padding(.top, 8)
                }
                .padding()

            } else {

                Text(errMessage)
                    .font(.title2)
                    .foregroundStyle(.primary)
                    .bold()

            }

            Spacer()
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

struct WeatherInfoView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.headline)
                .bold()
        }
    }
}


#Preview {
    WeatherView(
        weatherStruct: weatherResponseArr[0], query: .constant(""),
        selectedCity: .constant(""), errMessage: .constant("City not found"))
}
