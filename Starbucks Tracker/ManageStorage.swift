//
//  ManageStorage.swift
//  Starbucks Tracker
//
//  Created by Shashank Indukuri on 3/9/22.
//

import Foundation

class ManageStorage: ObservableObject {
    @Published var servings: [DrinkServing]
    
    // Path where data is stored
    let savePath = FileManager.documentsDirectory.appendingPathComponent("StoredDrinks")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            servings = try JSONDecoder().decode([DrinkServing].self, from: data)
            
        } catch {
            servings = []
        }
    }
    
    /**
     A method that save the data in the file manager in json format
     */
    func save() {
        do {
            let data = try JSONEncoder().encode(servings)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
    
    /**
     A method that adds the drink to orders and displays in summary
     */
    
    func add(drink: Drink, size: String, extraShots: Int, isDecaffe: Bool, milk: ConfigOptions, syrup: ConfigOptions, caffeine: Int, calories: Int) {
        var descriptionString = [String]()
        descriptionString.append(size)
        
        if isDecaffe {
            descriptionString.append("decaffeinated")
        }
        
        switch extraShots {
        case 0:
            break
        case 1:
            descriptionString.append("1 extra shot")
        default:
            descriptionString.append("\(extraShots) extra shots")
        }
        
        if milk != .none {
            descriptionString.append("\(milk.name.lowercased()) milk")
        }
        
        if syrup != .none {
            descriptionString.append("\(syrup.name.lowercased()) milk")
        }
        
        let description = descriptionString.joined(separator: ", ")
        
        let serving = DrinkServing(id: UUID(), name: drink.name, description: description, caffeine: caffeine, calories: calories)
        servings.insert(serving, at: 0)
        save()
    }
    
    /**
     A method to repeat the exisitng order
     */
    func reorder(serving: DrinkServing) {
        var copy = serving
        copy.id = UUID()
        servings.insert(copy, at: 0)
        save()
    }
    
    /**
     A method to delete the existing order
     */
    func delete(serving: DrinkServing) {
        if let index = servings.firstIndex(of: serving) {
            servings.remove(at: index)
            save()
        }
    }
}
