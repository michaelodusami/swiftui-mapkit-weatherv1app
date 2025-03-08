//
//  IdentifiableCoordinate.swift
//  WeatherV1
//
//  Created by Michael-Andre Odusami on 3/7/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//
import MapKit
import Foundation

struct IdentifiableCoordinate: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
