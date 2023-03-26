//
//  RepeatStyle.swift
//  Core
//
//  Created by 송영모 on 2023/03/26.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import RealmSwift

public enum RepeatStyle: Int, PersistableEnum {
    case none
    case daily
    case weekly
    case monthly
    case yearly
    
    public var title: String {
        switch self {
        case .none:
            return "None"
        case .daily:
            return "Daily"
        case .weekly:
            return "Weekly"
        case .monthly:
            return "Monthly"
        case .yearly:
            return "Yearly"
        }
    }
}
