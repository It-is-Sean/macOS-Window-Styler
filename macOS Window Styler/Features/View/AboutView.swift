//
//  AboutView.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/4.
//

import SwiftUI
import SwiftData

struct AboutView: View {
    var body: some View{
        HStack{
            Image(nsImage: NSApp.applicationIconImage)
        }
    }

}
#Preview{
    AboutView()
}
