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
        return startDate.isDate(inSameDayAs: date)
    }
    
    func offset(date: Date, index: Int) -> CGSize {
        if date.weekday == 1 {
            return .init(width: UIScreen.screenWidth / 7.0, height: self.height(index: index))
        } else {
            return .init(width: 0.0, height: self.height(index: index))
        }
    }
    
    func offset(index: Int) -> CGSize {
        if startDate.day(to: endDate) > 1 {
            return .init(width: UIScreen.screenWidth / 7.0, height: self.height(index: index))
        } else {
            return .init(width: 0.0, height: self.height(index: index))
        }
    }
    
    var width: CGFloat {
        return UIScreen.screenWidth / 7.0 * CGFloat(startDate.day(to: endDate))
    }
    
    func height(index: Int) -> CGFloat {
        return UIScreen.screenHeight * 0.08 / 5.0 * CGFloat(index)
    }
}
