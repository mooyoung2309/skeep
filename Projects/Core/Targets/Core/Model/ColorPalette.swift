//
//  ColorPalette.swift
//  Core
//
//  Created by 송영모 on 2023/03/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI

import RealmSwift

public enum ColorPalette: String, PersistableEnum {
    case clear
    case red
    case orange
    case yellow
    case green
    case mint
    case teal
    case cyan
    case blue
    case indigo
    case purple
    case pink
    case brown
    
    var color: Color {
        switch self {
        case .clear: return .clear
        case .red: return .red
        case .orange: return .orange
        case .yellow: return .yellow
        case .green: return .green
        case .mint: return .mint
        case .teal: return .teal
        case .cyan: return .cyan
        case .blue: return .blue
        case .indigo: return .indigo
        case .purple: return .purple
        case .pink: return .pink
        case .brown: return .brown
        }
    }
}
