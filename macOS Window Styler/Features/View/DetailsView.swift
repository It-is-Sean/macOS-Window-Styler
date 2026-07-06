//
//  DetailsView.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/3.
//

import SwiftUI
import SwiftData




struct DetailView: View {
    @State private var defaultDetailedSetting = detailedSettingItem(windowCornerRadious: 26, sidebarCornerRadious: 19, enableFloatSidebar: true)
    

    @State private var detailedSetting = detailedSettingItem(windowCornerRadious: 26, sidebarCornerRadious: 19, enableFloatSidebar: true)

    @State private var showResetAlert = false
    @State private var showApplyAlert = false

    var body: some View{
        VStack(alignment: .trailing, spacing: 14){
            VStack{
                HStack{
                    Text("Details")
                        .font(.system(.largeTitle,weight: .semibold))
                        .fontWidth(.expanded)
                    Spacer()
                }.padding(.leading, 5).padding(.bottom, -1)
                GroupBox{
                    VStack(alignment: .leading){
                        Text("Window Corner Radius").font(.body).bold().foregroundStyle(.secondary)
                        HStack{
                            Slider(value: Binding(
                                get: {Double(detailedSetting.windowCornerRadious)},
                                set: {detailedSetting.windowCornerRadious  = Int($0)}),
                                   in: 1...30)
                            Text("\(detailedSetting.windowCornerRadious)")
                                .font(.title2.monospacedDigit()).bold().foregroundStyle(.secondary)
                                .frame(width: 34, alignment: .center)
                                .contentTransition(.numericText())
                                .animation(.default, value: detailedSetting.windowCornerRadious)
                        }
                    }.padding(10)
                }
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
                        Divider()
                        HStack{
                            Text("Corner Radious")
                            Slider(value: Binding(
                                get: {Double(detailedSetting.sidebarCornerRadious)},
                                set: {detailedSetting.sidebarCornerRadious  = Int($0)}),
                                   in: 1...30)
                            Text("\(detailedSetting.sidebarCornerRadious)")
                                .font(.title2.monospacedDigit()).bold().foregroundStyle(.secondary)
                                .frame(width: 34, alignment: .center)
                                .contentTransition(.numericText())
                                .animation(.default, value: detailedSetting.sidebarCornerRadious)
                        }
                        .disabled(!detailedSetting.enableFloatSidebar)
                        .opacity(detailedSetting.enableFloatSidebar ? 1 : 0.4)
                        .animation(.default, value: detailedSetting.enableFloatSidebar)
                        .padding(3)
                    }.padding(7).frame(maxWidth: .infinity)
                }
                
            }
            Spacer()
            HStack{
                // reset
                Button(action: {
                    detailedSetting = defaultDetailedSetting
                    DefaultsApplier.applyDetail(detailedSetting)
                    showResetAlert = true

                }){
                    Text("Reset")
                }
                .buttonStyle(.glass)
                .alert("Reset Successful", isPresented: $showResetAlert) {
                        Button("Later", role: .cancel) {}
                        Button("Logout"){
                            logout()
                    }
                } message: {
                    Text("Reset saved. Log out to apply the change.")
                }
                // Apply
                Button(action: {
                    print("Applied")
                    DefaultsApplier.applyDetail(detailedSetting)
                    showApplyAlert = true
                }) {
                    HStack {
                        Image(systemName: "wand.and.stars")
                        Text("Apply")
                            .font(.headline)
                    }
                    .foregroundStyle(.white)

                }
                .buttonStyle(.glassProminent)
                .alert("Changes Saved", isPresented: $showApplyAlert) {
                    Button("Later", role: .cancel) {}
                    Button("Logout"){
                            logout()
                    }
                } message: {
                    Text("Changes saved. Log out to apply the changes.")
                }
                    
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }.padding().frame(maxWidth: .infinity)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
