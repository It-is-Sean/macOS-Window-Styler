//
//  Preset_View.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/3.
//

import SwiftUI

struct PresetView: View {
    @State private var allItems:[WindowPresetItem] = [
        WindowPresetItem(name: "macOS X", image: "preset_macos_x", windowCornerRadious: 10,sidebarCornerRadious: 0,enableFloatSidebar: false),
        WindowPresetItem(name: "macOS 15 Sequoia", image: "preset_macos_bigsur", windowCornerRadious: 18,sidebarCornerRadious: 0,enableFloatSidebar: false),
        WindowPresetItem(name: "macOS 26 Tahoe", image: "preset_macos_tahoe", windowCornerRadious: 26,sidebarCornerRadious: 19,enableFloatSidebar: true),
    ]
    @State private var selectedID: WindowPresetItem.ID? = nil
    @State private var showLogoutAlert = false
    var selectedItem: WindowPresetItem? {
        allItems.first {$0.id == selectedID}
    }
    var body: some View {
        VStack(alignment: .center, spacing: 14){

                Picker("Presets", selection: $selectedID){
                    ForEach(allItems) { item in
                        Text(item.name).tag(item.id as WindowPresetItem.ID?)
                    }
                }
                .pickerStyle(.palette)
                .labelsHidden()
                .fixedSize()

                Spacer()
                VStack(alignment: .leading){
                    Text("Preview:").font(.body).foregroundStyle(.secondary).bold()
                    Image(selectedItem?.image ?? "preset_macos_bigsur")
                        .resizable()
                        .scaledToFit()
                        //.frame(maxWidth: .infinity, maxHeight: 400)
                        .background(.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    print("Applied")
                    DefaultsApplier.applyPreset(selectedItem ?? WindowPresetItem(name: "macOS 26 Tahoe", image: "preset_macos_tahoe", windowCornerRadious: 26,sidebarCornerRadious: 19,enableFloatSidebar: true))
                    showLogoutAlert = true
                }) {
                    HStack {
                        Image(systemName: "wand.and.stars")
                        Text("Apply")
                            .font(.headline)
                    }
                    .alert("Preset Applied", isPresented: $showLogoutAlert) {
                            Button("Logout Later", role: .cancel) {}
                            Button("Logout"){
                                logout()
                            }
                    } message: {
                        Text("Preset has been applied. Log out to apply the changes.")
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
