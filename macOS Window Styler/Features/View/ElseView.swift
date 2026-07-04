//
//  ETCView.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/3.
//

import SwiftUI

struct ElseView: View {
    @State private var allItems:[WindowPresetItem] = [
        WindowPresetItem(name: "macOS X", image: "preset_macos_x", windowCornerRadious: 7,sidebarCornerRadious: 0,enableFloatSidebar: false),
        WindowPresetItem(name: "macOS 15 Big Sur", image: "preset_macos_bigsur", windowCornerRadious: 9,sidebarCornerRadious: 0,enableFloatSidebar: false),
        WindowPresetItem(name: "macOS 26 Tahoe", image: "preset_macos_tahoe", windowCornerRadious: 26,sidebarCornerRadious: 19,enableFloatSidebar: true),
    ]
    @State private var selectedID: WindowPresetItem.ID? = nil
    var selectedItem: WindowPresetItem? {
        allItems.first {$0.id == selectedID}
    }
    var body: some View {
        VStack(alignment: .trailing, spacing: 14){
            GroupBox{
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Sidebar").font(.body).bold().foregroundStyle(.secondary)
                        Toggle(isOn: $detailedSetting.enableFloatSidebar){
                            Text("Float Sidebar").frame(maxWidth: .infinity, alignment: .leading)
                        }
                            .toggleStyle(.switch)
                            .frame(maxWidth: .infinity)
                    }.frame(maxWidth: .infinity).padding(3)
            }

            HStack{
                Button(action: {
                    print("Reset")
                    DefaultsApplier.resetAll()
                }){
                    Text("Reset")
                }.buttonStyle(.automatic)
                Button(action: {
                    print("Add tapped")
                    DefaultsApplier.applyPreset(selectedItem ?? WindowPresetItem(name: "macOS 26 Tahoe", image: "preset_macos_tahoe", windowCornerRadious: 26,sidebarCornerRadious: 19,enableFloatSidebar: true))
                }) {
                    HStack {
                        Image(systemName: "wand.and.stars")
                        Text("Apply")
                            .font(.headline)
                    }
                    
                    
                    //.foregroundColor(.white)
                    //.background(Color.blue)
                    //.cornerRadius(10)
                    
                }            .buttonStyle(.borderedProminent)
                    
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }.padding()
        .onAppear{
            if selectedID == nil{
                selectedID = allItems.first?.id
            }
        }
    }
}

#Preview {
    ContentView()
}
