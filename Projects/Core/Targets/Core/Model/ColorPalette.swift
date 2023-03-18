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
    case `default`
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case gray
    
    public var color: Color {
        switch self {
        case .default: return Color(UIColor.systemGray6)
        case .red: return .red
        case .orange: return .orange
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        case .purple: return .purple
        case .gray: return .gray
        }
    }
}
