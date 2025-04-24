//
//  MapItem.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/21/25.
//
// MapItem.swift
//
//import Foundation
//import MapKit
//
//struct MapItem: Identifiable, Hashable, Equatable {
//    let id: UUID
//    let title: String
//    let coordinate: CLLocationCoordinate2D
//    let isLost: Bool
//
//    static func == (lhs: MapItem, rhs: MapItem) -> Bool {
//        lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}

import Foundation
import CoreLocation

struct MapItem: Identifiable, Hashable, Equatable {
    let id: UUID
    let title: String
    let coordinate: CLLocationCoordinate2D
    let isLost: Bool

    static func == (lhs: MapItem, rhs: MapItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
