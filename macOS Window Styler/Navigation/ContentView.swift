//
//  ContentView.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/3.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedSection: SidebarSections? = .presets
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView{
 
                List(SidebarSections.allCases, selection: $selectedSection) { section in
                    Label(section.rawValue, systemImage: section.iconName).tag(section)
                }
        } detail: {
            switch selectedSection {
            case .presets, .none:
                PresetView()
            case .details:
                DetailView()
            //case .animations:
                //AnimationView()
            case .more_content:
                ElseView()
            case .reset:
                ResetView()
            }
        }
        .navigationTransition(.automatic)


    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
