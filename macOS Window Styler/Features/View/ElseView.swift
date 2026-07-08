//
//  ETCView.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/3.
//

import SwiftUI

struct ElseView: View {
    //[TODO]: defaults write -g NSSolariumWindowTabs -bool NO "removing the liquid glass effect from tabs (and only tabs in any app like safari or finder)"

    //[TODO]: defaults write NSGlobalDomain NSMenuEnableActionImages -bool false: "remove all those new extra unneeded icons in menus"
    //[TODO]: Change YES/NO to true/false
    @State private var windowMinimizeSLowMotionSetting = defaultSettingItem(
        defaultField: "com.apple.dock", defaultKey: "slow-motion-allowed",
        defaultSettingValue: "NO", dType: "bool")
    @State private var pressCmdCtrlToDragWindowSetting = defaultSettingItem(
        defaultField: "-g", defaultKey: "NSSolariumWindowTabs", defaultSettingValue: "YES",
        dType: "bool")
    @State private var pressCmdCtrlToDragWindowAnimationSetting = defaultSettingItem(
        defaultField: "NSGlobalDomain", defaultKey: "NSMenuEnableActionImages",
        defaultSettingValue: "YES", dType: "bool")


    var body: some View {
        VStack {
            HStack{
                Text("Else")
                    .font(.system(.largeTitle,weight: .semibold))
                    .fontWidth(.expanded)
                Spacer()
            }.padding(.leading, 5).padding(.bottom, -1)
            GroupBox {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Animations").font(.body).bold().foregroundStyle(.secondary)
                        Toggle(
                            isOn: Binding(
                                get: {
                                    windowMinimizeSLowMotionSetting.defaultSettingValue == "YES"
                                },
                                set: { newValue in
                                    windowMinimizeSLowMotionSetting.defaultSettingValue =
                                        newValue ? "YES" : "NO"

                                }
                            )
                        ) {
                            Text("Enable slow motion minimizing effect when shift is pressed")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .toggleStyle(.switch)
                        .frame(maxWidth: .infinity)
                    }.frame(maxWidth: .infinity).padding(3)
                }.padding(7)

            }

            GroupBox {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Window Decorations").font(.body).bold().foregroundStyle(.secondary)
                        Toggle(
                            isOn: Binding(
                                get: {
                                    pressCmdCtrlToDragWindowSetting.defaultSettingValue == "YES"
                                },
                                set: { newValue in
                                    pressCmdCtrlToDragWindowSetting.defaultSettingValue =
                                        newValue ? "YES" : "NO"
                                }
                            )
                        ) {
                            Text("Enable liquid glass effect for tabs").frame(
                                maxWidth: .infinity, alignment: .leading)
                        }
                        .toggleStyle(.switch)
                        .frame(maxWidth: .infinity)
                        Divider()
                        Toggle(
                            isOn: Binding(
                                get: {
                                    pressCmdCtrlToDragWindowAnimationSetting.defaultSettingValue
                                        == "YES"
                                },
                                set: { newValue in
                                    pressCmdCtrlToDragWindowAnimationSetting.defaultSettingValue =
                                        newValue ? "YES" : "NO"
                                }
                            )
                        ) {
                            Text("Enable menus icons").frame(
                                maxWidth: .infinity, alignment: .leading)
                        }
                        .toggleStyle(.switch)
                        .frame(maxWidth: .infinity)

                    }.frame(maxWidth: .infinity)
                        .padding(3)
                }.padding(7)
            }
            Spacer()
            HStack {
                Spacer()
                applyAndRebootButtom{
                    print("Applied")
                    DefaultsApplier.applyItem(windowMinimizeSLowMotionSetting)
                    DefaultsApplier.applyItem(pressCmdCtrlToDragWindowSetting)
                    if pressCmdCtrlToDragWindowSetting.defaultSettingValue == "TRUE" {
                        DefaultsApplier.applyItem(pressCmdCtrlToDragWindowAnimationSetting)
                    }
                }
            }            .controlSize(.large)

        }.padding()

    }
}
