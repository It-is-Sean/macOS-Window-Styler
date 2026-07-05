import AppKit
//
//  DefaultsCmdModel.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/3.
//
import Foundation


struct WindowPresetItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let image: String
    let windowCornerRadious: Int
    let sidebarCornerRadious: Int
    let enableFloatSidebar: Bool
}

struct detailedSettingItem: Hashable {
    var windowCornerRadious: Int
    var sidebarCornerRadious: Int
    var enableFloatSidebar: Bool
}

struct defaultSettingItem: Hashable {
    var defaultField: String
    var defaultKey: String
    var defaultSettingValue: String
    var dType: String
}

enum DefaultsApplier {
    static let globalDefaults = UserDefaults(suiteName: UserDefaults.globalDomain)
    //[TODO]: Combine the three togother using defaultsSettingItem struct
    static func applyPreset(_ preset: WindowPresetItem) {
        // Apply Radious
        dfWrite(
            key: "NSConvolutionOverride1", value: String(preset.windowCornerRadious), type: "float")
        dfWrite(
            key: "NSSplitViewItemGlassMinimumCornerRadius",
            value: String(preset.sidebarCornerRadious), type: "float")
        // Apply Sidebar
        dfWrite(
            key: "NSSplitViewItemSidebarDefaultsToFloatingAppearance",
            value: String(preset.enableFloatSidebar), type: "bool")

    }

    static func applyDetail(_ settings: detailedSettingItem) {
        // Apply Radious
        dfWrite(
            key: "NSConvolutionOverride1", value: String(settings.windowCornerRadious),
            type: "float")
        dfWrite(
            key: "NSSplitViewItemGlassMinimumCornerRadius",
            value: String(settings.sidebarCornerRadious), type: "float")
        // Apply Sidebar
        dfWrite(
            key: "NSSplitViewItemSidebarDefaultsToFloatingAppearance",
            value: String(settings.enableFloatSidebar), type: "bool")
    }
    
    static func applyItem(_ setting: defaultSettingItem) {
        dfWrite(key: setting.defaultKey, value: setting.defaultSettingValue, type: setting.dType,field: setting.defaultField)
    }

    static func resetAll() {
        dfDelete(key: "NSConvolutionOverride1")
        dfDelete(key: "NSSplitViewItemGlassMinimumCornerRadius")
        dfDelete(key: "NSSplitViewItemSidebarDefaultsToFloatingAppearance")
        dfDelete(key: "NSSolariumWindowTabs")
        dfDelete(key: "NSMenuEnableActionImages", domain: "NSGlobalDomain")
        dfDelete(key: "slow-motion-allowed",domain: "com.apple.dock")
    }

    static func dfWrite(key: String, value: String, type: String? = nil, field: String = "-g") {
        var args = ["write", field, key]
        if let type { args.append("-\(type)") }
        args.append(value)
        run("/usr/bin/defaults", args)
    }

    static func dfDelete(key: String, domain: String = "-g") {
        var args = ["delete", domain, key]
        run("/usr/bin/defaults", args)
    }

    @discardableResult
    static func run(_ launchPath: String, _ args: [String]) -> Int32 {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: launchPath)
        task.arguments = args
        do {
            // [TODO]: Make the task run in the background
            try task.run()
            task.waitUntilExit()
            return task.terminationStatus
        } catch {
            print("run faild \(launchPath) \(args) -> \(error)")
            return -1
        }
    }
}
