//
//  LocationSearchService.swift
//  WeatherV1
//
//  Created by Tise on 3/8/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//
import MapKit

class LocationSearchService: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchQuery: String = "" {
        didSet { completer.queryFragment = searchQuery }
    }
    @Published var searchResults: [MKLocalSearchCompletion] = []
    
    private let completer: MKLocalSearchCompleter
    
    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        completer.delegate = self
        // Set to the entire world by using a large region
        completer.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 360)
        )
    }
    
    // Update search results when completer finds matches.
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Search completer error: \(error.localizedDescription)")
    }
    
    // Perform a local search based on the selected completion.
    func selectLocation(_ completion: MKLocalSearchCompletion,
                        completionHandler: @escaping (CLLocationCoordinate2D?) -> Void) {
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let coordinate = response?.mapItems.first?.placemark.coordinate,
                  error == nil else {
                print("Error searching location: \(error?.localizedDescription ?? "Unknown error")")
                completionHandler(nil)
                return
            }
            completionHandler(coordinate)
        }
    }
}


