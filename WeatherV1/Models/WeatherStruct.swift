//
//  WeatherStruct.swift
//  WeatherV1
//
//  Created by Michael-Andre Odusami on 3/7/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.

import Foundation


// MARK: - Weather API Models
struct WeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: MainWeather
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainWeather: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int?
    let grnd_level: Int?
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct Rain: Codable {
    let oneH: Double?
    
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
    }
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String
    let sunrise: Int
    let sunset: Int
}
/*
 as mentioned, we call this api after receiving the lat and long for a specific place
 https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
*/
