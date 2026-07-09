//
//  ViewModels.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/6.
//
import SwiftUI

struct applyAndRebootButtom: View{
    @State private var showLogoutAlert = false
    let action: () -> Void
    var body:some View{
        Button(action: {
            action()
            showLogoutAlert = true
        }) {
            HStack {
                Image(systemName: "wand.and.stars")
                Text("Apply")
                    .font(.headline)
            }
            
            .foregroundColor(.white)
            //.background(Color.blue)
            //.cornerRadius(10)
            
        }
        .controlSize(.large)
        .buttonStyle(.glassProminent)
        .alert("Restart Needed", isPresented: $showLogoutAlert) {
            Button("Later", role: .cancel) {}
            Button("Now", role: .destructive){
                reboot()
            }
        } message: {
            Text("Restart your mac to apply the change.")
        }
    }
}

struct applyAndLogoutButtom: View{
    @State private var showLogoutAlert = false
    let action: () -> Void
    var body:some View{
        Button(action: {
            action()
            showLogoutAlert = true
        }) {
             HStack {
                 Image(systemName: "wand.and.stars")
                 Text("Apply")
                     .font(.headline)
             }
             .foregroundStyle(.white)

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
             
         }
         .controlSize(.large)
         .buttonStyle(.glassProminent)
    }
}
struct resetAndLogoutButtom: View{
    @State private var showResetAlert = false
    let action: () -> Void
    var body:some View{
        Button(action: {
            action()
            showResetAlert = true
        }){
            Label("Reset", systemImage: "arrow.trianglehead.counterclockwise")
        }
        .buttonStyle(.glass)
        .controlSize(.large)
        .alert("Reset Successful", isPresented: $showResetAlert) {
                Button("Later", role: .cancel) {}
                Button("Logout"){
                    logout()
                
            }
        } message: {
            Text("Reset saved. Log out to apply the change.")
        }
    }
}

struct resetAllAndLRebootButtom: View{
    @State private var showResetAlert = false
    @State private var showRebootAlert = false

    var body:some View{
        Button(action: {
            showResetAlert = true
        }){
            Label("Reset", systemImage: "arrow.trianglehead.counterclockwise")
        }

        .buttonStyle(.glassProminent)
        .controlSize(.large)
        .tint(.red.opacity(0.55))
        .alert("Reset All Setting？", isPresented: $showResetAlert) {
            Button("No", role: .cancel) {}
            Button("Yes", role: .destructive) {
                DefaultsApplier.resetAll()
                showRebootAlert = true
            }
        } message: {
            Text("Reset all settings to your syetem default.")
        }
        .alert("Reset Successful", isPresented: $showRebootAlert) {
            Button("Later", role: .cancel) {}
            Button("Restart"){
                reboot()
            }
        } message: {
            Text("You need to restart mac to apply the those changes.")
        }
    }
}

