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
                //onAppear {
                //    model.load()
                //}
        }
        Window("About This App", id: "about") {
            
        }
        .windowResizability(.contentMinSize)
        .windowResizability(.contentMinSize)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("About macOS Window Styler") {
                    NSApp.orderFrontStandardAboutPanel(options: [
                        .applicationName: "macOS Window Styler",
                        .version: "1.0"
                    ])
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
