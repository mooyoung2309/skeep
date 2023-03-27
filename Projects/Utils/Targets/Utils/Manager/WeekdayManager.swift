//
//  WeekdayManager.swift
//  Utils
//
//  Created by 송영모 on 2023/03/26.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

public class WeekdayManager {
    public static func toUInt8(weekday: Int) -> UInt8 {
        switch weekday {
        case 1: return 0b00000001
        case 2: return 0b00000010
        case 3: return 0b00000100
        case 4: return 0b00001000
        case 5: return 0b00010000
        case 6: return 0b00100000
        case 7: return 0b01000000
        default: return 0b00000000
        }
    }
    
    public static func toWeekdays(weekdays: UInt8) -> [Int] {
        return [0]
    }
}
