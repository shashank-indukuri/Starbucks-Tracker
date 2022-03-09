//
//  MainMenuView.swift
//  Starbucks Tracker
//
//  Created by Shashank Indukuri on 3/9/22.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var menu: Menu
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText = ""
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, pinnedViews: .sectionHeaders) {
                    ForEach(menu.sections) {section in
                        Section {
                            ForEach(section.filters(for: searchText)) {drink in
                                NavigationLink {
                                    DetailView(drink: drink) {
                                        dismiss()
                                    }
                                } label: {
                                    VStack {
                                        Image(drink.image)
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(10)
                                        
                                        Text(drink.name)
                                            .font(.system(.body, design: .serif))
                                    }
                                    .padding(.bottom)
                                }
                                .buttonStyle(.plain)
                            }
                        } header: {
                            Text(section.name)
                                .font(.system(.title, design: .serif))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.top, .bottom, .trailing], 5)
                                .background(.background)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Add Drinks")
            .searchable(text: $searchText)
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(Menu())
    }
}
