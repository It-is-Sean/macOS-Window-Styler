//
//  macOS_Window_StylerApp.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/3.
//

import SwiftUI
import SwiftData

@main
struct macOS_Window_StylerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        Window("macOS Window Styler", id: "main") {
            ContentView()
                // .environmentObject(model)
                .frame(minWidth: 720, minHeight: 520)
                //.containerBackground(.thinMaterial, for: .window)

                .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
                //onAppear {
                //    model.load()
                //}
        }
        .windowStyle(.hiddenTitleBar)
        //.windowBackgroundDragBehavior(.enabled)
        .commands {
            CommandGroup(replacing: .appInfo) {
                AboutMenuButton()
            }
        }
        
        
        Window("About The App", id: "about") {
            AboutView()
                .containerBackground(.thickMaterial, for: .window)
    
        }
        .windowResizability(.contentSize)
        .modelContainer(sharedModelContainer)
        .windowStyle(.hiddenTitleBar)
        .windowBackgroundDragBehavior(.enabled)
    }
}
struct AboutMenuButton: View {
    @Environment(\.openWindow) private var openWindow
    var body: some View {
        Button {
            openWindow(id: "about")
        } label: {
            Label("About macOS Windows Styler", systemImage: "info.circle")
        }
    }
}
