//
//  MainMenuSection.swift
//  Starbucks Tracker
//
//  Created by Shashank Indukuri on 3/9/22.
//

import Foundation

// Modal to store the menu data
struct MainMenuSection: Identifiable, Codable {
    let id: UUID
    let name: String
    let drinks: [Drink]
    
    /**
     A methods that filters the drinks from the input text
     */
    func filters(for searchText: String) -> [Drink] {
        let trimmedString = searchText.trimmingCharacters(in: .whitespaces)
        
        if trimmedString.isEmpty {
            return drinks
        }
        
        return drinks.filter {
            $0.name.localizedCaseInsensitiveContains(trimmedString)
        }
    }
}
