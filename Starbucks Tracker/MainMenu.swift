//
//  MainMenu.swift
//  Starbucks Tracker
//
//  Created by Shashank Indukuri on 3/9/22.
//

import Foundation

class MainMenu: ObservableObject, Codable {
    let sections: [MainMenuSection]
    var milkOptions = [ConfigOptions.none]
    var syrupOptions = [ConfigOptions.none]
    
    init() {
        // Load the json data from the file
        do {
            let url = Bundle.main.url(forResource: "menu", withExtension: "json")!
            let data = try Data(contentsOf: url)
            let menu = try JSONDecoder().decode(MainMenu.self, from: data)
            
            // read the json data and add it to the modals
            sections = menu.sections
            milkOptions.append(contentsOf: menu.milkOptions)
            syrupOptions.append(contentsOf: menu.syrupOptions)
        } catch {
            // Throw an unexpected exceptions
            fatalError("Menu couldn't load. Please try again...")
        }
    }
}
