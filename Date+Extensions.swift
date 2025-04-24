//
//  Date+Extensions.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//

import Foundation

extension Date {
    func timeAgoString() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}




