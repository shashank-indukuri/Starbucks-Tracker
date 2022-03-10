//
//  ConfigOptions.swift
//  Starbucks Tracker
//
//  Created by Shashank Indukuri on 3/9/22.
//

import Foundation

// Modal to configure the data
struct ConfigOptions: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let calories: Int
    
    // It holds the nill
    static let none = ConfigOptions(id: UUID(), name: "None", calories: 0)
}
