//
//  AboutView.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/4.
//

import SwiftUI
import SwiftData

import AppKit

struct AboutView: View {
    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
    @State private var isIconHovered = false
    @State private var isLinkHovered = false
    @State private var hoverTask: Task<Void, Never>?
    @State private var tilt: CGSize = .zero
    private let maxTiltDegrees: Double = 7
    
    private let hoverGLowDelay: UInt64 = 450_000_000
    var body: some View{
        HStack(alignment: .center, spacing: 4){
            Image(nsImage: NSApp.applicationIconImage)
                .scaleEffect(isIconHovered ? 1.15 : 1.0)
                .rotation3DEffect(
                    
                    isIconHovered ? .degrees(Double(-tilt.height) * maxTiltDegrees) : .degrees(0),
                    axis: (x: 1, y: 0, z: 0),
                    anchor: .center,
                    anchorZ: 0,
                    perspective: 0.6
                )
                .rotation3DEffect(
                    isIconHovered ? .degrees(Double(tilt.width) * maxTiltDegrees) : .degrees(0),
                    axis: (x: 0, y: 1, z: 0),
                    anchor: .center,
                    anchorZ: 0,
                    perspective: 0.6
                )
                .shadow(
                    color: isIconHovered ? .accentColor.opacity(0.65) : .clear,
                    radius: isIconHovered ? 13 : 0
                )
                .animation(.spring(duration: isIconHovered ? 0.5 : 0.4), value: isIconHovered)
                .onContinuousHover{phase in
                    switch phase {
                    case .active(let location):
                        let size = NSApp.applicationIconImage.size
                        guard size.width > 0, size.height > 0 else {return}
                        tilt = CGSize(
                            width: (location.x/size.width) * 2 - 1, height: (location.y/size.height) * 2 - 1
                        )
                        
                    case .ended:
                        tilt = .zero
                    }
                }
                .onHover { hovering in
                    hoverTask?.cancel()
                    
                    if hovering{
                        hoverTask = Task{
                            try? await Task.sleep(nanoseconds: hoverGLowDelay)
                            guard !Task.isCancelled else {return}
                            await MainActor.run {
                                isIconHovered = true
                                NSHapticFeedbackManager.defaultPerformer.perform(
                                    .alignment,
                                    performanceTime: .now

                                )
                            }
                        }
                    } else {
                        isIconHovered = false
                        NSHapticFeedbackManager.defaultPerformer.perform(
                            .alignment,
                            performanceTime: .now

                        )
                    }
                }
            
            VStack(alignment: .leading, spacing: 4){
                Text("macOS Window Styler")
                    .font(.system(.title,weight: .semibold))
                    .fontWidth(.expanded)
                Text("Built by Sean • Version \(appVersion)")
                    .font(.system(.subheadline, weight: .light))
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 13)
                    .fontWidth(.expanded)
                Link(destination: URL(string: "https://github.com/It-is-Sean/macOS-Window-Styler")!) {
                    Label("GitHub Repo", systemImage: "arrow.up.forward.app.fill")
                        .buttonStyle(.plain)
                        .fontWidth(.expanded)
                }
                .shadow(
                    color: isLinkHovered ? .blue.opacity(0.5) : .clear,
                    radius: isLinkHovered ? 3.5 : 0
                )
                .animation(.easeIn(duration: isLinkHovered ? 0.1 : 0.35), value: isLinkHovered)
                .onHover{linkHovering in
                    isLinkHovered = linkHovering
                    
                }
            }.windowResizeBehavior(.disabled)
        }.padding(.bottom)
            .padding(.horizontal)
    }

}
#Preview{
    AboutView()
}
