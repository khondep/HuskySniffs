//
//  MappableCoordinate.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/21/25.
//

//// MappableCoordinate.swift
//import CoreLocation
//
//struct MappableCoordinate: Identifiable {
//    let coordinate: CLLocationCoordinate2D
//    var id: String { "\(coordinate.latitude)-\(coordinate.longitude)" }
//}

//// MARK: - MappableCoordinate.swift
//import CoreLocation
//
//struct MappableCoordinate: Identifiable, Equatable, Hashable {
//    let coordinate: CLLocationCoordinate2D
//    var id: String { "\(coordinate.latitude)-\(coordinate.longitude)" }
//
//    static func == (lhs: MappableCoordinate, rhs: MappableCoordinate) -> Bool {
//        lhs.coordinate.latitude == rhs.coordinate.latitude &&
//        lhs.coordinate.longitude == rhs.coordinate.longitude
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(coordinate.latitude)
//        hasher.combine(coordinate.longitude)
//    }
//}
//
//// MARK: - MappableCoordinate.swift
//import CoreLocation
//
//struct MappableCoordinate: Identifiable, Equatable {
//    let coordinate: CLLocationCoordinate2D
//    var id: String { "\(coordinate.latitude)-\(coordinate.longitude)" }
//}

//
//import CoreLocation
//
//struct MappableCoordinate: Identifiable, Equatable, Hashable {
//    let coordinate: CLLocationCoordinate2D
//    var id: String { "\(coordinate.latitude)-\(coordinate.longitude)" }
//
//    static func == (lhs: MappableCoordinate, rhs: MappableCoordinate) -> Bool {
//        lhs.coordinate.latitude == rhs.coordinate.latitude &&
//        lhs.coordinate.longitude == rhs.coordinate.longitude
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(coordinate.latitude)
//        hasher.combine(coordinate.longitude)
//    }
//}
