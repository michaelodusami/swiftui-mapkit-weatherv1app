//
//  ContentView.swift
//  WeatherV1
//
//  Created by Tise on 3/7/25.
//

import SwiftUI

struct ContentView: View {

    @State private var showSearch: Bool = false
    @State private var query: String = ""
    @State private var selectedCity: String = ""
    @State private var errMessage: String = "City not searched for..."
    @State private var weather: WeatherResponse? = nil

    var body: some View {
        VStack {
            WeatherView(
                weatherStruct: weather, query: $query,
                selectedCity: $selectedCity, errMessage: $errMessage)
            Button(action: {
                showSearch = true

            }) {
                Text("Search for new city")
            }
            .opacity(showSearch ? 0.0 : 1.0)
            .padding(.vertical)

        }
        .padding()
        .sheet(isPresented: $showSearch) {
            HStack {
                TextField("Enter city name...", text: $query)
                    .padding()
                    .background(Color(.systemGray6))
                    .textFieldStyle(.plain)
                    .textInputAutocapitalization(.words)
                    .onSubmit {
                        // if something is valid, then set the selected city
                        selectedCity = query.localizedLowercase.capitalized
                        errMessage =
                            "\(selectedCity) not found. \nPlease search again"
                        query = ""
                        showSearch = false
                        searchForCity()

                    }
            }
            .padding(.horizontal)
            .presentationDetents([.height(100)])  // Small bottom sheet
            .presentationDragIndicator(.visible)

        }
    }

    private func searchForCity() {
        guard
            let geocodingUrl = URL(
                string:"https://api.openweathermap.org/geo/1.0/direct?q=\(selectedCity)&limit=1&appid=\(apiKey)"
            )
        else {
            DispatchQueue.main.async {
                self.errMessage = "Invalid URL for city search."
                self.weather = nil
            }
            return
        }

        URLSession.shared.dataTask(with: geocodingUrl) {
            data, response, error in

            if let error = error {
                DispatchQueue.main.async {
                    self.errMessage =
                        "Error fetching geocoding data: \(error.localizedDescription)"
                    self.weather = nil
                }
            }

            // Ensure data is received.
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errMessage = "No data received from geocoding API."
                    self.weather = nil
                }
                return
            }

            do {
                let geocodingResults = try JSONDecoder().decode(
                    [GeocodingStruct].self, from: data)
                // Use the first result if available.
                guard let firstResult = geocodingResults.first else {
                    DispatchQueue.main.async {
                        self.errMessage =
                            "City not found. Please try another search."
                        self.weather = nil
                    }
                    return
                }

                // 4. Extract latitude and longitude from the geocoding result.
                let latitude = firstResult.lat
                let longitude = firstResult.lon

                // 5. Build the URL for the weather API call using the obtained coordinates.
                guard
                    let weatherURL = URL(
                        string:
                            "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
                    )
                else {
                    DispatchQueue.main.async {
                        self.errMessage = "Invalid URL for weather data."
                        self.weather = nil
                    }
                    return
                }

                URLSession.shared.dataTask(with: weatherURL) {
                    weatherData, weatherResponse, weatherError in
                    // Check for errors in fetching weather data.
                    if let weatherError = weatherError {
                        DispatchQueue.main.async {
                            self.errMessage =
                                "Error fetching weather data: \(weatherError.localizedDescription)"
                        }
                        return
                    }

                    // Ensure weather data is received.
                    guard let weatherData = weatherData else {
                        DispatchQueue.main.async {
                            self.errMessage =
                                "No data received from weather API."
                        }
                        return
                    }

                    do {
                        // 7. Decode the weather data into WeatherResponse.
                        let weatherResponseData = try JSONDecoder().decode(
                            WeatherResponse.self, from: weatherData)

                        // 8. Update your SwiftUI state on the main thread.
                        DispatchQueue.main.async {
                            self.weather = weatherResponseData
                            self.errMessage = ""
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.errMessage =
                                "Failed to decode weather data: \(error.localizedDescription)"
                            self.weather = nil
                        }
                    }
                }.resume()  // Start the weather data task.

            } catch {
                DispatchQueue.main.async {
                    self.errMessage =
                        "Failed to decode geocoding data: \(error.localizedDescription)"
                    self.weather = nil
                }
            }
        }.resume()

    }
}

#Preview {
    ContentView()
}
