//
//  ResetView.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/4.
//
import SwiftUI
struct ResetView: View{
    @State private var defaultDetailedSetting = detailedSettingItem(windowCornerRadious: 26, sidebarCornerRadious: 19, enableFloatSidebar: true)
    var body: some View {
        VStack {
            HStack{
                Text("Reset")
                    .font(.system(.largeTitle,weight: .semibold))
                    .fontWidth(.expanded)
                Spacer()
            }.padding(.leading, 5).padding(.bottom, -1)
            GroupBox {
                VStack(alignment: .leading) {
                    HStack{
                        Text("Reset Windows Decoraion Settings").font(.body).bold().foregroundStyle(.secondary)
                        Spacer()
                        resetAndLogoutButtom{
                            DefaultsApplier.applyDetail(defaultDetailedSetting)
                        }
                    }
                    Divider()
                    HStack{
                        Text("Reset All Settings").font(.body).bold().foregroundStyle(.secondary)
                        Spacer()
                        resetAllAndLRebootButtom()
                    }
                    
                }.padding(10)
            }
            Spacer()
        }.padding()
    }
}
