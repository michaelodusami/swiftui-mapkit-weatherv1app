//
//  WeatherV1App.swift
//  WeatherV1
//
//  Created by Tise on 3/7/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import SwiftUI

/*
 Features Included:
 Libraries To Use: MapKit, UserSettings For Cache, SwiftUI
 APIS: URLSession
 
 Vision:
 On the main page, a user can search for any location, once a location has been searched for,
 the coordinates will be extracted and will be used to display a WeatherDetailScreen
 This WeatherDetailScreen will display both the coordinates of where the location is on the map (in globe format) which will be on half of the screen with the bottom half of the screen relative weather data.
 */

@main
struct WeatherV1App: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
