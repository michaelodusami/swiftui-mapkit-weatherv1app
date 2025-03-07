//
//  WeatherStruct.swift
//  WeatherV1
//
//  Created by Tise on 3/7/25.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: CurrentWeather
    let alerts: [WeatherAlert]?
}

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double?
    let weather: [Weather]
}

// MARK: - Weather
struct Weather: Codable, Identifiable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - WeatherAlert
struct WeatherAlert: Codable {
    let sender_name: String
    let event: String
    let start: Int
    let end: Int
    let description: String
    let tags: [String]
}



/*
 as mentioned, we call this api after receiving the lat and long for a specific place
 https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={minutely, hourly, daily, alerts}&appid={API key}
*/
