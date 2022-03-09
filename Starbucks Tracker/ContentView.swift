//
//  ContentView.swift
//  Starbucks Tracker
//
//  Created by Shashank Indukuri on 3/9/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var menu = MainMenu()
    @StateObject var storage = ManageStorage()
    @State private var displayMenu = false
    
    var totalCaffeine: Int {
        storage.servings.map(\.caffeine).reduce(0, +)
    }
    
    var totalCalories: Int {
        storage.servings.map(\.calories).reduce(0, +)
    }
    
    var body: some View {
        NavigationView {
            List {
                if storage.servings.isEmpty {
                    Button {
                        displayMenu = true
                    } label: {
                        Label("Add Your First Drink", systemImage: "cart.fill")
                    }
                } else {
                    Section("Summary") {
                        Text("**Caffeine**: \(totalCaffeine)mg")
                        Text("**Calories**: \(totalCalories)")
                    }
                    ForEach(storage.servings) { serving in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(serving.name)
                                    .font(.headline)
                                Text(serving.description)
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
                            Text("\(serving.caffeine)mg")
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    storage.delete(serving: serving)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                storage.reorder(serving: serving)
                            } label: {
                                Label("Reorder", systemImage: "repeat")
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
            .sheet(isPresented: $displayMenu, content: MainMenuView.init)
            .navigationTitle("Chill Beans")
            .toolbar {
                Button {
                    displayMenu = true
                } label: {
                    Label("Add New Drink", systemImage: "plus")
                }
            }
        }
            .environmentObject(menu)
            .environmentObject(storage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
