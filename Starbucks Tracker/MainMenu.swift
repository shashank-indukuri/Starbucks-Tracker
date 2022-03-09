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
        do {
            let url = Bundle.main.url(forResource: "menu", withExtension: "json")!
            let data = try Data(contentsOf: url)
            let menu = try JSONDecoder().decode(MainMenu.self, from: data)
            sections = menu.sections
            milkOptions.append(contentsOf: menu.milkOptions)
            syrupOptions.append(contentsOf: menu.syrupOptions)
        } catch {
            fatalError("Menu couldn't load. Please try again...")
        }
    }
}
