//
//  DrinkServing.swift
//  Starbucks Tracker
//
//  Created by Shashank Indukuri on 3/9/22.
//

import Foundation

struct DrinkServing: Identifiable, Codable, Equatable {
    var id: UUID
    let name: String
    let description: String
    let caffeine: Int
    let calories: Int
}
