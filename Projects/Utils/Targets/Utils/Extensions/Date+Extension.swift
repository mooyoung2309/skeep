//
//  Date+Extension.swift
//  Utils
//
//  Created by 송영모 on 2023/03/19.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

extension Date {
    public func calendarDates() -> [Date] {
        let calendar = Calendar.current
        
        let startOfMonthDate = self.startOfMonth()
        let endOfMonthDate = self.endOfMonth()
        
        let currentMonthDates = self.getDaysOfMonth()
        var prevMonthDates: [Date] = []
        var nextMonthDates: [Date] = []
        var calendarDates: [Date] = []
        
        for i in 1...7 {
            let date = calendar.date(byAdding: .day, value: -i, to: startOfMonthDate)!
            let weekDay = calendar.component(.weekday, from: date)
            
            prevMonthDates.append(date)
            
            if weekDay == 2 {
                break
            }
        }
        
        for i in 1...7 {
            let date = calendar.date(byAdding: .day, value: i, to: endOfMonthDate)!
            let weekDay = calendar.component(.weekday, from: date)
            
            nextMonthDates.append(date)
            
            if weekDay == 1 {
                break
            }
        }
        
        calendarDates.append(contentsOf: prevMonthDates.reversed())
        calendarDates.append(contentsOf: currentMonthDates)
        calendarDates.append(contentsOf: nextMonthDates)
        
        return calendarDates
    }
    
    func startOfMonth() -> Date {
        let cal = Calendar.current
        let comps = cal.dateComponents([.year, .month], from: self)
        return cal.date(from: comps)!
    }
    
    func endOfMonth() -> Date {
        let cal = Calendar.current
        let comps = cal.dateComponents([.year, .month], from: self)
        let date = cal.date(from: comps)!
        let lastDayOfMonth = cal.date(byAdding: DateComponents(month: 1, day: -1), to: date)!
        return lastDayOfMonth
    }
    
    func getDaysOfMonth() -> [Date] {
        let cal = Calendar.current
        let monthRange = cal.range(of: .day, in: .month, for: self)!
        let comps = cal.dateComponents([.year, .month], from: self)
        var date = cal.date(from: comps)!
        var dates: [Date] = []
        for _ in monthRange {
            dates.append(date)
            date = cal.date(byAdding: .day, value: 1, to: date)!
        }
        return dates
    }
}
