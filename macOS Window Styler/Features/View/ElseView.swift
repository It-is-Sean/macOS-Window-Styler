//
//  ETCView.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/3.
//

import SwiftUI

struct ElseView: View {
    //[TODO]: Change YES/NO to true/false
    @State private var windowMinimizeSLowMotionSetting = defaultSettingItem(
        defaultField: "com.apple.dock", defaultKey: "slow-motion-allowed",
        defaultSettingValue: "NO", dType: "bool")
    @State private var pressCmdCtrlToDragWindowSetting = defaultSettingItem(
        defaultField: "-g", defaultKey: "NSWindowShouldDragOnGesture", defaultSettingValue: "NO",
        dType: "bool")
    @State private var pressCmdCtrlToDragWindowAnimationSetting = defaultSettingItem(
        defaultField: "-g", defaultKey: "NSWindowShouldDragOnGestureFeedback",
        defaultSettingValue: "TRUE", dType: "bool")

    @State private var showLogoutAlert = false
    var body: some View {
        VStack {
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
                        Text("Gestures").font(.body).bold().foregroundStyle(.secondary)
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
                            Text("Press 􀆔 + 􀆍 to drag window at any palce").frame(
                                maxWidth: .infinity, alignment: .leading)
                        }
                        .toggleStyle(.switch)
                        .frame(maxWidth: .infinity)
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
                            Text("Enable bounce effect when drag the window").frame(
                                maxWidth: .infinity, alignment: .leading)
                        }
                        .toggleStyle(.switch)
                        .frame(maxWidth: .infinity)
                        .disabled(pressCmdCtrlToDragWindowSetting.defaultSettingValue != "YES")
                        .opacity(
                            pressCmdCtrlToDragWindowSetting.defaultSettingValue == "YES" ? 1 : 0.4
                        )
                        .animation(
                            .default,
                            value: pressCmdCtrlToDragWindowSetting.defaultSettingValue == "YES")

                    }.frame(maxWidth: .infinity)
                        .padding(3)
                }.padding(7)
            }
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    print("Applied")
                    DefaultsApplier.applyItem(windowMinimizeSLowMotionSetting)
                    DefaultsApplier.applyItem(pressCmdCtrlToDragWindowSetting)
                    if pressCmdCtrlToDragWindowSetting.defaultSettingValue == "TRUE" {
                        DefaultsApplier.applyItem(pressCmdCtrlToDragWindowAnimationSetting)
                    }
                    showLogoutAlert = true
                }) {
                    HStack {
                        Image(systemName: "wand.and.stars")
                        Text("Apply")
                            .font(.headline)
                    }

                    //.foregroundColor(.white)
                    //.background(Color.blue)
                    //.cornerRadius(10)

                }
                .buttonStyle(.borderedProminent)
                .alert("Changes Saved!", isPresented: $showLogoutAlert) {
                    HStack {
                        Button("Later", role: .cancel) {}
                        Button("Restart Dock") {
                            killAll(target: "Dock")
                        }
                    }
                } message: {
                    Text("Restart dock to apply the change.")
                }

            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

        }.padding()

    }
}
