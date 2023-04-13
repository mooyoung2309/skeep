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
        return startDate.isDate(inSameDayAs: date) || date.weekday == 1
    }
    
    func offset(date: Date, index: Int) -> CGSize {
        let term = self.term(date: date)
        
        print("[D] \(title) -> \(term)")
        
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
        
        if date.weekOfMonth == startDate.weekOfMonth {
            return 7 - startDate.weekday
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
