//
//  File+Extension.swift
//  FeatureCalendar
//
//  Created by 송영모 on 2023/04/05.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import Core
import Utils
import UIKit

extension File {
    func isHead(date: Date) -> Bool {
        if startDate.isDate(inSameDayAs: date) {
            return true
        } else if self.term(date: date) >= 1 && date.weekday == 1 {
            return true
        } else {
            switch repeatStyle {
            case .none:
                return startDate.isDate(inSameDayAs: date) || date.weekday == 1
            case .daily:
                return WeekdayManager.toWeekdays(uint8: .init(weekdays)).contains(date.weekday)
            case .weekly:
                return date.weekday == startDate.weekday
            case .monthly:
                return date.day == startDate.day
            case .yearly:
                return date.month == startDate.month && date.day == startDate.day
            }
        }
    }
    
    func offset(date: Date, index: Int) -> CGSize {
        let term = self.term(date: date)
        
        if term > 1 {
            return .init(width: (UIScreen.screenWidth - 20.0) / 7.0 / 2.0 * CGFloat(term - 1), height: UIScreen.screenHeight * 0.08 / 5.0 * CGFloat(index))
        } else {
            return .init(width: 0.0, height: UIScreen.screenHeight * 0.08 / 5.0 * CGFloat(index))
        }
    }
    
    func term(date: Date) -> Int {
        if startDate.weekOfMonth == endDate.weekOfMonth {
            return self.term
        } else if date.weekOfMonth == startDate.weekOfMonth {
            return 8 - startDate.weekday
        } else if date.weekOfMonth == endDate.weekOfMonth {
            return endDate.weekday
        } else {
            return 7
        }
    }
    
    var term: Int {
        return startDate.day(to: endDate)
    }
    
    func width(date: Date) -> CGFloat {
        return (UIScreen.screenWidth - 20.0) / 7.0 * CGFloat(CGFloat(term(date: date)))
    }
}
