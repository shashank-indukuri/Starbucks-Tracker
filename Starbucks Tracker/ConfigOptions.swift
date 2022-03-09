//
//  ConfigOptions.swift
//  Starbucks Tracker
//
//  Created by Shashank Indukuri on 3/9/22.
//

import Foundation

struct ConfigOptions: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let calories: Int
    
    static let none = ConfigOptions(id: UUID(), name: "None", calories: 0)
}
