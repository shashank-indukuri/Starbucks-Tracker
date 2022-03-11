//
//  OrderView.swift
//  Starbucks Tracker
//
//  Created by Shashank Indukuri on 3/9/22.
//

import SwiftUI

struct OrderView: View {
    let drink: Drink
    let dismiss: () -> Void
    
    @EnvironmentObject var menu: MainMenu
    @EnvironmentObject var storage: ManageStorage
    @State private var index = 0
    @State private var isDecaffe = false
    @State private var extraShots = 0
    @State private var milk = ConfigOptions.none
    @State private var syrup = ConfigOptions.none
    @State private var isFirst = true
    
    // Size options
    let sizeOptions = ["Short", "Tall", "Grande", "Venti"]
    
    // Computed property to calculate caffeine
    var caffeine: Int {
        var caffeineAmount = drink.caffeine[index]
        caffeineAmount += (extraShots * 60)

        if isDecaffe {
            caffeineAmount /= 20
        }

        return caffeineAmount
    }

    // Computed property to calculate  calories
    var calories: Int {
        var calorieAmount = drink.baseCalories
        calorieAmount += extraShots * 10

        if drink.coffeeBased {
            calorieAmount += milk.calories
        } else {
            calorieAmount += milk.calories / 8
        }

        calorieAmount += syrup.calories
        return calorieAmount * (index + 1)
    }
    
    // Detail view
    var body: some View {
        Form {
            Section("Basic Options") {
                Picker("Choose a Size", selection: $index) {
                    ForEach(sizeOptions.indices) { size in
                        Text(sizeOptions[size])
                    }
                }
                .pickerStyle(.segmented)
                
                if drink.coffeeBased {
                    Stepper("Extra shots: \(extraShots)", value: $extraShots, in: 0...8)
                }
                
                Toggle("Decaffeinated", isOn: $isDecaffe)
            }
            
            Section("Customizations") {
                Picker("Milk", selection: $milk) {
                    ForEach(menu.milkOptions) { option in
                        Text(option.name)
                            .tag(option)
                    }
                }

                if drink.coffeeBased {
                    Picker("Syrup", selection: $syrup) {
                        ForEach(menu.syrupOptions) { option in
                            Text(option.name)
                                .tag(option)
                        }
                    }
                }
            }
            
            Section("Estimates") {
                Text("**Caffeine**: \(caffeine) mg")
                Text("**Calories**: \(calories)")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(drink.name)
        .toolbar {
            // Save button that adds the drink to the list
            Button("Save") {
                storage.add(drink: drink, size: sizeOptions[index], extraShots: extraShots, isDecaffe: isDecaffe, milk: milk, syrup: syrup, caffeine: caffeine, calories: calories)
                
                dismiss()
            }
        }
        .onAppear {
            guard isFirst else {
                return
            }
            
            if drink.servedWithMilk {
                milk = menu.milkOptions[1]
            }
            isFirst = false
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(drink: Drink.example) { }
        .environmentObject(MainMenu())
    }
}
