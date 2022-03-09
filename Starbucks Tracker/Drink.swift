//
//  Drink.swift
//  Starbucks Tracker
//
//  Created by Shashank Indukuri on 3/9/22.
//

import Foundation

struct Drink: Identifiable, Codable {
    let id: UUID
    let name: String
    let caffeine: [Int]
    let coffeeBased: Bool
    let servedWithMilk: Bool
    let baseCalories: Int
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "-")
    }
    
    static let example = Drink(id: UUID(), name: "Drink", caffeine: [20, 40, 60], coffeeBased: true, servedWithMilk: true, baseCalories: 50)
}
