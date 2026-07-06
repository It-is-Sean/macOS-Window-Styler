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
    @State private var showResetAlert = false
    @State private var showRebootAlert = false
    var body: some View {
        NavigationSplitView {
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
                PresetView()
            }
        }
        .navigationTransition(.automatic)
        .onChange(of: selectedSection) { _, newValue in
            if newValue == .reset {
                showResetAlert = true
                selectedSection = .presets
            }
        }
        .alert("Reset All Setting？", isPresented: $showResetAlert) {
            Button("No", role: .cancel) {}
            Button("Yes", role: .destructive) {
                DefaultsApplier.resetAll()
                showRebootAlert = true
            }
        } message: {
            Text("Reset all settings to your syetem default.")
        }
        .alert("Reset Successful", isPresented: $showRebootAlert) {
            Button("Restart Later", role: .cancel) {}
            Button("Restart"){
                reboot()
            }
        } message: {
            Text("Restart mac to apply the change.")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
