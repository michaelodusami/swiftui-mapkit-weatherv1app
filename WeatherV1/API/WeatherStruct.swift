//
//  WeatherStruct.swift
//  WeatherV1
//
//  Created by Tise on 3/7/25.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let id: Int
    let name: String
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int
    let grnd_level: Int
}

// MARK: - Weather
struct Weather: Codable, Identifiable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}




/*
 as mentioned, we call this api after receiving the lat and long for a specific place
 
 https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
*/
