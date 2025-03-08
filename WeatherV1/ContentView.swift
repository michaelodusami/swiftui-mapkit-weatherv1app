//
//  ContentView.swift
//  WeatherV1
//
//  Created by Tise on 3/7/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

//
//  ContentView.swift
//  WeatherV1
//
//  Created by Tise on 3/7/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var showSearch: Bool = false
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var selectedCity: String = ""
    @State private var navigateToWeather: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Search for a Location") {
                    showSearch = true
                }
                .padding()
                .sheet(isPresented: $showSearch) {
                    NavigationView {
                        LocationSearchView { coordinate, city in
                            selectedCoordinate = coordinate
                            selectedCity = city
                            showSearch = false
                            navigateToWeather = true
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("Weather V1")
            .navigationDestination(isPresented: $navigateToWeather) {
                if let coordinate = selectedCoordinate {
                    WeatherDetailView(coordinate: coordinate, cityName: selectedCity)
                }
            }
        }
    }
}

