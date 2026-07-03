//
//  DefaultsCmdModel.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/3.
//
import Foundation
import AppKit

func logout(showConfirmation: Bool = true) {
    let eventID: AEEventID = showConfirmation
        ? kAELogOut          // 'logo' —— 弹确认框
        : kAEReallyLogOut    // 'rlgo' —— 不确认,直接注销

    let target = NSAppleEventDescriptor(bundleIdentifier: "com.apple.loginwindow")
    let event = NSAppleEventDescriptor(
        eventClass: kCoreEventClass,      // 'aevt'
        eventID: eventID,
        targetDescriptor: target,
        returnID: AEReturnID(kAutoGenerateReturnID),
        transactionID: AETransactionID(kAnyTransactionID)
    )

    do {
        try event.sendEvent(options: [.noReply], timeout: TimeInterval(kAEDefaultTimeout))
    } catch {
        print("Logout failed: \(error)")
    }
}
struct WindowPresetItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let image: String
    let windowCornerRadious: Int
    let sidebarCornerRadious: Int
    let enableFloatSidebar: Bool
}

struct detailedSettingItem: Hashable{
    var windowCornerRadious: Int
    var sidebarCornerRadious: Int
    var enableFloatSidebar: Bool
}

enum DefaultsApplier {
    static func applyPreset(_ preset: WindowPresetItem){
        // Apply Radious
        dfWrite(key: "NSConvolutionOverride1", value: String(preset.windowCornerRadious), type: "float")
        dfWrite(key: "NSSplitViewItemGlassMinimumCornerRadius", value: String(preset.sidebarCornerRadious), type: "float")
        // Apply Sidebar
        dfWrite(key: "NSSplitViewItemSidebarDefaultsToFloatingAppearance", value: String(preset.enableFloatSidebar), type: "bool")

    }
    
    static func applyDetail(_ settings: detailedSettingItem){
        // Apply Radious
        dfWrite(key: "NSConvolutionOverride1", value: String(settings.windowCornerRadious), type: "float")
        dfWrite(key: "NSSplitViewItemGlassMinimumCornerRadius", value: String(settings.sidebarCornerRadious), type: "float")
        // Apply Sidebar
        dfWrite(key: "NSSplitViewItemSidebarDefaultsToFloatingAppearance", value: String(settings.enableFloatSidebar), type: "bool")
    }
    
    
    static func resetAll(){
        dfDelete(key: "NSConvolutionOverride1")
        dfDelete(key: "NSSplitViewItemGlassMinimumCornerRadius")
        dfDelete(key: "NSSplitViewItemSidebarDefaultsToFloatingAppearance")
    }
    
    static func dfWrite(key:String,value: String, type: String? = nil) {
        var args = ["write", "-g", key]
        if let type {args.append("-\(type)")}
        args.append(value)
        run("/usr/bin/defaults", args)
    }
    
    
    static func dfDelete(key:String){
        var args = ["delete", "-g", key]
        run("/usr/bin/defaults", args)
    }
    
    
    @discardableResult
    static func run (_ launchPath: String, _ args: [String]) -> Int32 {
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
