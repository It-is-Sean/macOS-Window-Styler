//
//  Utils.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/5.
//


import AppKit
import Foundation

func logout(showConfirmation: Bool = true) {
    let eventID: AEEventID =
        showConfirmation
        ? kAELogOut
        : kAEReallyLogOut

    let target = NSAppleEventDescriptor(bundleIdentifier: "com.apple.loginwindow")
    let event = NSAppleEventDescriptor(
        eventClass: kCoreEventClass,  // 'aevt'
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

func reboot() {
    let target = NSAppleEventDescriptor(bundleIdentifier: "com.apple.loginwindow")
    let event = NSAppleEventDescriptor(
        eventClass: kCoreEventClass,  // 'aevt'
        eventID: kAERestart,
        targetDescriptor: target,
        returnID: AEReturnID(kAutoGenerateReturnID),
        transactionID: AETransactionID(kAnyTransactionID)
    )

    do {
        try event.sendEvent(options: [.noReply], timeout: TimeInterval(kAEDefaultTimeout))
    } catch {
        print("Reboot failed: \(error)")
    }
}

func killAll(target: String){
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/killall")
    process.arguments = [target]
    do {
        try process.run()
    } catch{
        print("killall \(target) Failed: \(error)")
    }
}
