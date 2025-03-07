//
//  Globals.swift
//  WeatherV1
//
//  Created by Tise on 3/7/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import Foundation

var weatherResponseArr: [WeatherResponse] = []

func loadWeatherResponse() {
    if let tempResponseArr: [WeatherResponse] = decodeJsonIntoStruct(
        fullFilename: "weatherResponseData.json", fileLocation: "Main Bundle")
    {
        weatherResponseArr = tempResponseArr
    } else {
        print("Something went wrong with loading the JSON file")
    }
}
