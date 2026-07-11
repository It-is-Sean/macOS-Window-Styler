//
//  DetailsView.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/3.
//

import SwiftUI
import SwiftData




struct DetailView: View {
    private let defaultDetailedSetting = detailedSettingItem(windowCornerRadious: 26, sidebarCornerRadious: 19, enableFloatSidebar: true)
    

    @State private var detailedSetting = detailedSettingItem(windowCornerRadious: 26, sidebarCornerRadious: 19, enableFloatSidebar: true)
    @State private var windowCornerRadiousValue:Double = 26
    @State private var siderbarCornerRadiousValue: Double = 19
    
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
                            Slider(value: $windowCornerRadiousValue,
                                   in: 1...30,
                            onEditingChanged: { editing in
                                if !editing{
                                    detailedSetting.windowCornerRadious = Int(windowCornerRadiousValue)
                                }
                            })
                            Text("\(Int(windowCornerRadiousValue))")
                                .font(.title2.monospacedDigit()).bold().foregroundStyle(.secondary)
                                .frame(width: 34, alignment: .center)
                                .contentTransition(.numericText())
                                .animation(.default, value: Int(windowCornerRadiousValue))
                                .onChange(of: Int(windowCornerRadiousValue)){
                                    NSHapticFeedbackManager.defaultPerformer.perform(
                                        .alignment,
                                        performanceTime: .now

                                    )
                                }
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
                            Slider(value: $siderbarCornerRadiousValue,
                                   in: 1...26,
                                   onEditingChanged: { editing in
                                    if !editing{
                                        detailedSetting.sidebarCornerRadious = Int(siderbarCornerRadiousValue)
                                    
                                    }
                            })
                            
                            Text("\(Int(siderbarCornerRadiousValue))")
                                .font(.title2.monospacedDigit()).bold().foregroundStyle(.secondary)
                                .frame(width: 34, alignment: .center)
                                .contentTransition(.numericText())
                                .animation(.default, value: Int(siderbarCornerRadiousValue))
                                .onChange(of: Int(siderbarCornerRadiousValue)) {
                                    NSHapticFeedbackManager.defaultPerformer.perform(
                                        .alignment,
                                        performanceTime: .now
                                    )
                                }
                        }.frame(maxWidth: .infinity).padding(3)
                    }.padding(7).frame(maxWidth: .infinity)
                }
                
            }
            Spacer()
            HStack{
                // reset
                resetAndLogoutButtom{
                    detailedSetting = defaultDetailedSetting
                    DefaultsApplier.applyDetail(detailedSetting)
                }
                // Apply
                applyAndLogoutButtom{
                    print("Applied")
                    DefaultsApplier.applyDetail(detailedSetting)
                }
                    
            }
            .buttonStyle(.borderedProminent)

        }.padding().frame(maxWidth: .infinity)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
