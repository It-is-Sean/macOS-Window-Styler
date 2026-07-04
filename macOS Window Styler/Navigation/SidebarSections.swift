//
//  SidevarSelections.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/3.
//


enum SidebarSections: String, CaseIterable, Identifiable {
    case presets = "Presets"
    case details = "Details"
    case more_content = "Else"
    case reset = "Reset"
    var id: String {self.rawValue}
    
    var iconName: String  {
        switch self {
        case .presets: return "books.vertical"
        case .details: return "pencil.and.outline"
        case .more_content: return "ellipsis.circle"
        case .reset: return "arrow.trianglehead.clockwise"
        }
    }
}
