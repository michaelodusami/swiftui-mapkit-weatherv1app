//
//  WeatherDetailView.swift
//  WeatherV1
//
//  Created by Michael-Andre Odusami on 3/8/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import MapKit
import SwiftUI

struct WeatherDetailView: View {

    let coordinate: CLLocationCoordinate2D
    let cityName: String

    @State private var weather: WeatherResponse?
    @State private var errorMessage: String = ""
    @State private var query: String = ""
    @State private var mapPosition: MapCameraPosition
    
    init(coordinate: CLLocationCoordinate2D, cityName: String) {
            self.coordinate = coordinate
            self.cityName = cityName
            // Initialize the camera position
            _mapPosition = State(initialValue: .region(
                MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            ))
        }

    var body: some View {
        ScrollView {

            Map(position: $mapPosition) {
                Marker(cityName, coordinate: coordinate)
            }
            .frame(height: 300)
            .cornerRadius(12)
            .padding()

            if let weather = weather {
                VStack(alignment: .leading, spacing: 8) {
                    Text(cityName)
                        .font(.largeTitle)
                        .bold()
                    Text(weather.weather.first?.description.capitalized ?? "")
                        .font(.title2)

                    HStack(spacing: 16) {
                        if let icon = weather.weather.first?.icon {
                            AsyncImage(
                                url: URL(
                                    string:
                                        "https://openweathermap.org/img/wn/\(icon)@2x.png"
                                )
                            ) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                        }
                        Text("\(weather.main.temp, specifier: "%.1f")° F")
                            .font(.system(size: 50))
                            .bold()
                    }

                    Text(
                        "Feels like \(weather.main.feels_like, specifier: "%.1f")° F"
                    )
                    .font(.title3)

                    HStack {
                        Text(
                            "Min: \(weather.main.temp_min, specifier: "%.1f")° F"
                        )
                        Text(
                            "Max: \(weather.main.temp_max, specifier: "%.1f")° F"
                        )
                    }
                    .font(.body)

                    Text("Pressure: \(weather.main.pressure) hPa")
                    Text("Humidity: \(weather.main.humidity)%")

                    if let rain = weather.rain?.oneH {
                        Text("Rain (1h): \(rain) mm")
                    }

                    Text("Wind: \(weather.wind.speed, specifier: "%.1f") mph")
                }
                .padding()
            } else {
                Text(errorMessage.isEmpty ? "Loading weather..." : errorMessage)
                    .padding()
            }

            Spacer()
        }
        .navigationTitle(cityName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { fetchWeather() }
    }

    func fetchWeather() {
        let urlString =
            "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(apiKey)&units=imperial"
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received."
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(
                    WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self.weather = weatherResponse
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage =
                        "Decoding error: \(error.localizedDescription)"
                }
                print("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }

}

