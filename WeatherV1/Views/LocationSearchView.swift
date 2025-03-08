import MapKit
//
//  LocationSearchView.swift
//  WeatherV1
//
//  Created by Tise on 3/8/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//
import SwiftUI

struct LocationSearchView: View {
    @StateObject private var searchService = LocationSearchService()

    var onLocationSelected: ((CLLocationCoordinate2D, String) -> Void)

    var body: some View {
        VStack {
            TextField("Search for a location", text: $searchService.searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            List(searchService.searchResults, id: \.self) { result in
                Button {
                    searchService.selectLocation(result) { coordinate in
                        if let coordinate = coordinate {
                            onLocationSelected(coordinate, result.title)
                        }
                    }
                } label: {
                    VStack(alignment: .leading) {
                        Text(result.title)
                            .font(.headline)
                        Text(result.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .listStyle(.plain)
            Spacer()
        }
        .navigationTitle("Location Search")
    }
}


