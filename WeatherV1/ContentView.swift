//
//  ContentView.swift
//  WeatherV1
//
//  Created by Tise on 3/7/25.
//

import SwiftUI

/*
 Welcome!!!!!
 Today we will be building a weather app showcasing API handling
 */

struct ContentView: View {
    var body: some View {
        WeatherView(weatherStruct: weatherResponseArr[0])
    }
}

#Preview {
    ContentView()
}
