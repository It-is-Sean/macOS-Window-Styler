//
//  SidevarSelections.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/3.
//


enum SidebarSections: String, CaseIterable, Identifiable {
    case presets = "Presets"
    case details = "Details"
    case reset = "Reset"
    // case animations = "Animations & Else"
    var id: String {self.rawValue}
    
    var iconName: String  {
        switch self {
        case .presets: return "books.vertical"
        case .details: return "pencil.and.outline"
        // case .animations: return "hand.rays"
        case .reset: return "arrow.trianglehead.clockwise"
        }
    }
}
