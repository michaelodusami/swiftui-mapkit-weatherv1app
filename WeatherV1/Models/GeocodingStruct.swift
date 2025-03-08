//
//  GeocodingStruct.swift
//  WeatherV1
//
//  Created by Michael-Andre Odusami on 3/7/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.

import Foundation

/*
 To Call Geocoding:
 http://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid={API key}
 */

struct GeocodingStruct: Codable {
    var name: String
    var lat: Double
    var lon: Double
    var country: String
    var state: String
}
