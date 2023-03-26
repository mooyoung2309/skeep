//
//  HabitStyle.swift
//  Core
//
//  Created by 송영모 on 2023/03/26.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import RealmSwift

public enum HabitStyle: Int, PersistableEnum {
    case `default`
    case hidden
    
    public var isShow: Bool {
        if self == .hidden {
            return false
        } else {
            return true
        }
    }
}
